﻿
///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

Перем ВыполнятьЗамерИнициализирован;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;
	
	Ванесса.ДобавитьШагВМассивТестов(
		ВсеТесты, 
		"ЯБудуВыполнятьЗамерПроизводительности(Парам01)",
		"ЯБудуВыполнятьЗамерПроизводительности",
		"Допустим я буду выполнять замер производительности 'Выполнять''"
		,""
		,"");
	Ванесса.ДобавитьШагВМассивТестов(
		ВсеТесты,
		"ЯНачинаюЗамерПроизводительности()",
		"ЯНачинаюЗамерПроизводительности",
		"Допустим Я начинаю замер производительности",
		"",
		"");
	Ванесса.ДобавитьШагВМассивТестов(
		ВсеТесты,
		"ЯЗавершаюЗамерПроизводительности()",
		"ЯЗавершаюЗамерПроизводительности",
		"Допустим Я завершаю замер производительности",
		"",
		"");
		
	Возврат ВсеТесты;
	
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Функция выполняется перед началом каждого сценария
Функция ПередНачаломСценария() Экспорт
	//ИнициализацияЗамера();
КонецФункции

&НаКлиенте
// Функция выполняется перед окончанием каждого сценария
Функция ПередОкончаниемСценария() Экспорт
	
КонецФункции


///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

//Допустим Я буду выполнять замер производительности
//@ЯБудуВыполнятьЗамерПроизводительности()
&НаКлиенте
Функция ЯБудуВыполнятьЗамерПроизводительности(Буду = Истина) Экспорт

	 УстановитьВыполнятьЗамер(Буду);
	 ИнициализацияЗамера();
		
КонецФункции

&НаКлиенте
//Допустим Я начинаю замер производительности
//@ЯНачинаюЗамерПроизводительности()
Функция ЯНачинаюЗамерПроизводительности() Экспорт
				
	Если НЕ ВыполнятьЗамер() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Если НЕ ЗамерИнициализирован() Тогда
		ИнициализацияЗамера();
	КонецЕсли;	
		
	ПараметрыСоединенияОтладки = ПараметрыСоединенияОтладки();
	ЯНачинаюЗамерПроизводительностиПоАдресуПорт(ПараметрыСоединенияОтладки.Адрес, ПараметрыСоединенияОтладки.Порт);
	
	Возврат "";

КонецФункции

&НаКлиенте
//Допустим Я завершаю замер производительности
//@ЯЗавершаюЗамерПроизводительности()
Функция ЯЗавершаюЗамерПроизводительности() Экспорт
				
	Если НЕ ВыполнятьЗамер() 
		ИЛИ НЕ ЗамерИнициализирован() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ПараметрыСоединенияОтладки = ПараметрыСоединенияОтладки();
	ЯЗавершаюЗамерПроизводительностиПоАдресуПорт(ПараметрыСоединенияОтладки.Адрес, ПараметрыСоединенияОтладки.Порт);
	
КонецФункции

&НаКлиенте
Функция ЯНачинаюЗамерПроизводительностиПоАдресуПорт(АдресХоста, Порт)
	
	HTTPСоединение = Новый HTTPСоединение(АдресХоста, Порт, , , , 5);
	
	Заголовки = Новый Соответствие();
	Заголовки.Вставить("accept-charset", "utf-8");
	Заголовки.Вставить("content-type", "application/xml");
	
	HTTPЗапрос = Новый HTTPЗапрос("/e1crdbg/rdbg?cmd=setMeasureMode", Заголовки);
	HTTPЗапрос.УстановитьТелоИзСтроки(ТелоЗапросаВключитьЗамер());
	
	Попытка
		Результат = HTTPСоединение.ОтправитьДляОбработки(HTTPЗапрос);
	Исключение
		СообщитьПользователю("Не смог запустить замер. Ошибка соединения с сервером отладки. Ввыполенние замеров прекращено");
		УстановитьВыполнятьЗамер(Ложь);
	КонецПопытки;
	
КонецФункции

&НаКлиенте
Функция ЯЗавершаюЗамерПроизводительностиПоАдресуПорт(АдресХоста, Порт) 
	
	HTTPСоединение = Новый HTTPСоединение(АдресХоста, Порт, , , , 5);
		
	Заголовки = Новый Соответствие();
	Заголовки.Вставить("accept-charset", "utf-8");
	Заголовки.Вставить("content-type", "application/xml");
	
	HTTPЗапрос = Новый HTTPЗапрос("/e1crdbg/rdbg?cmd=setMeasureMode", Заголовки);
	HTTPЗапрос.УстановитьТелоИзСтроки(ТелоЗапросаВыключитьЗамер());
	
	Попытка
		Результат = HTTPСоединение.ОтправитьДляОбработки(HTTPЗапрос);
	Исключение
		УстановитьВыполнятьЗамер(Ложь);
		СообщитьПользователю("Ошибка соединения с сервером отладки. Выполнение замеров прекращено.");
	КонецПопытки;
	
КонецФункции

&НаКлиенте
Функция ПараметрыСоединенияОтладки()
	
	ПараметрыСоединенияОтладки = Неопределено;
	Ванесса.Объект.ДополнительныеПараметры.Свойство("ПараметрыСоединенияОтладки", ПараметрыСоединенияОтладки);
	
	Если ПараметрыСоединенияОтладки = Неопределено Тогда
		ПараметрыСоединенияОтладки = ПараметрыСоединенияОтладкиПоУмолчанию();
	КонецЕсли;	
	
	Возврат ПараметрыСоединенияОтладки;

КонецФункции

&НаКлиенте
Функция ПараметрыСоединенияОтладкиПоУмолчанию()
	
	Возврат Новый Структура("Адрес, Порт", "localhost", 1550);
 	
КонецФункции	

&НаКлиенте
Функция ВыполнятьЗамер()
	
	ВыполнятьЗамер = Ванесса.Объект.ДополнительныеПараметры.Свойство("ВыполнятьЗамер")       
		И Ванесса.Объект.ДополнительныеПараметры.ВыполнятьЗамер;
		
	Возврат ВыполнятьЗамер;	
	
КонецФункции	

&НаКлиенте
Процедура УстановитьВыполнятьЗамер(ДаНет)
	
	Ванесса.Объект.ДополнительныеПараметры.Вставить("ВыполнятьЗамер", ДаНет);       
	
КонецПроцедуры

&НаКлиенте
Функция ТелоЗапросаВключитьЗамер()
	
	Возврат Ванесса.Объект.ДополнительныеПараметры.ПараметрыЗамера.ТекстыЗапросов.ВключитьЗамер; 
	 	
КонецФункции

&НаКлиенте
Функция ТелоЗапросаВыключитьЗамер()
	
	Возврат Ванесса.Объект.ДополнительныеПараметры.ПараметрыЗамера.ТекстыЗапросов.ВыключитьЗамер; 
	
КонецФункции

&НаСервере
Функция ТекстыЗапросовНаСервере()
	
	Тексты = Новый Структура;
	Тексты.Вставить(
		"ВключитьЗамер",
		ПолучитьМакетСервер("ВключитьЗамер").ПолучитьТекст()
		);
	Тексты.Вставить(
		"ВыключитьЗамер",
		ПолучитьМакетСервер("ВыключитьЗамер").ПолучитьТекст()
		);
		
	Возврат Тексты;
	
КонецФункции	

&НаКлиенте
Функция ЗамерИнициализирован()
	
	Инициализирован = Ложь;
	Если Ванесса.Объект.ДополнительныеПараметры.Свойство("ПараметрыЗамера")
		И Ванесса.Объект.ДополнительныеПараметры.ПараметрыЗамера.Свойство("ЗамерИнициализирован")
		И Ванесса.Объект.ДополнительныеПараметры.ПараметрыЗамера.ЗамерИнициализирован Тогда
		
		Инициализирован = Истина;
		
	КонецЕсли;	
		
	Возврат Инициализирован;
	
КонецФункции	
	
&НаКлиенте
Процедура ИнициализацияЗамера()
	
	Если НЕ ВыполнятьЗамер() Тогда
		Возврат;
	КонецЕсли;	
	
	ПараметрыЗамера = Новый Структура;
	 
	Макеты = ТекстыЗапросовНаСервере();
	ПараметрыЗамера.Вставить("ТекстыЗапросов", Макеты);
	ПараметрыЗамера.Вставить("ЗамерИнициализирован", Истина);
	Ванесса.Объект.ДополнительныеПараметры.Вставить("ПараметрыЗамера", ПараметрыЗамера);
	
	ПараметрыИзСтроки = РазложитьСтрокуАдресОтладчика(Ванесса.Объект.АдресОтладчика);
	УстановитьПараметрыСоединенияОтладки(ПараметрыИзСтроки.Адрес, ПараметрыИзСтроки.Порт);
	
КонецПроцедуры	

&НаКлиенте
Процедура УстановитьПараметрыСоединенияОтладки(Адрес, Порт)
	
	ОписаниеТипа = Новый ОписаниеТипов("Число");
	ПортЧислом = ОписаниеТипа.ПривестиЗначение(Порт);
	
	ПараметрыСоединенияОтладки = Новый Структура;
	ПараметрыСоединенияОтладки.Вставить("Адрес", Строка(Адрес));
	ПараметрыСоединенияОтладки.Вставить("Порт", ПортЧислом);
	
	Ванесса.Объект.ДополнительныеПараметры.Вставить("ПараметрыСоединенияОтладки", ПараметрыСоединенияОтладки);
	
КонецПроцедуры

&НаКлиенте
Функция РазложитьСтрокуАдресОтладчика(АдресОтладчика)
	
	ПараметрыОтладки = ПараметрыСоединенияОтладки();
	
	СтрокаОтладки = СтрЗаменить(НРег(АдресОтладчика), "http://", "");
	ПозицияРазделителя = Вычислить("СтрНайти(СтрокаОтладки, "":"", НаправлениеПоиска.СКонца)");
	Адрес = Лев(СтрокаОтладки, ПозицияРазделителя - 1);
	Порт = Сред(СтрокаОтладки, ПозицияРазделителя + 1);
	
	Если ЗначениеЗаполнено(Адрес) Тогда
		ПараметрыОтладки.Адрес = Адрес;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Порт) Тогда
		ПараметрыОтладки.Порт = Порт;
	КонецЕсли;
	
	
	Возврат ПараметрыОтладки;
	
КонецФункции	
	
&НаКлиентеНаСервереБезКонтекста
Процедура СообщитьПользователю(Знач Сообщение) Экспорт
		
	ТекстСообщения = Формат(ТекущаяДата(), "ДЛФ=DT") + " " + Сообщение;
	
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = ТекстСообщения;
	Сообщение.Сообщить();
		
КонецПроцедуры

