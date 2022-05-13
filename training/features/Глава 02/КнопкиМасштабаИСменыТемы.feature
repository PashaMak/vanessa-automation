﻿# language: ru

@lessons

Функционал: Интерактивная справка. Масштаб в редакторе и с смена темы.

Сценарий: Масштаб в редакторе и с смена темы.

	* Привет! В этом уроке я расскажу тебе про то, как изменить масштаб текста в редакторе и сменить тему. Давай откроем второй экземпляр Ванессы в режиме обучения.
		И я открываю Vanessa Automation в режиме обучения
		И я скрываю часть кнопок командной панели редактора в режиме обучения

	* Загрузим тестовый пример.
		И я загружаю фичи в VA в режиме обучения "$КаталогИнструментов$\training\features\Примеры\ПримерМасштабВРедакторе.feature"

	* Редактор Vanessa Automation позволяет увеличивать или уменьшать размер текста.
	* Чтобы увеличить масштаб надо нажать на эту кнопку.	
		И Я делаю подсветку элемента формы VA по имени "VanessaEditorViewZoomIn" "Увеличить масштаб"
		И Пауза 0.1
		И я делаю клик по элементу формы VA UI Automation 'ЭтотСеанс' 'VanessaEditorViewZoomIn'
		И Пауза 0.1
		И я делаю клик по элементу формы VA UI Automation 'ЭтотСеанс' 'VanessaEditorViewZoomIn'
		И Пауза 0.1
		И я делаю клик по элементу формы VA UI Automation 'ЭтотСеанс' 'VanessaEditorViewZoomIn'
		И Пауза 0.1

	* Чтобы уменьшить масштаб надо нажать на эту кнопку.	
		И Я делаю подсветку элемента формы VA по имени "VanessaEditorViewZoomOut" "Уменьшить масштаб"
		И Пауза 0.1
		И я делаю клик по элементу формы VA UI Automation 'ЭтотСеанс' 'VanessaEditorViewZoomOut'
		И Пауза 0.1
		И я делаю клик по элементу формы VA UI Automation 'ЭтотСеанс' 'VanessaEditorViewZoomOut'
		И Пауза 0.1

	* Чтобы сброисить масштаб на значение по умолчанию надо нажать на эту кнопку	
		И Я делаю подсветку элемента формы VA по имени "VanessaEditorViewZoomReset" "Сбросить масштаб"
		И Пауза 0.1
		И я делаю клик по элементу формы VA UI Automation 'ЭтотСеанс' 'VanessaEditorViewZoomReset'
		И Пауза 0.1

	* Ещё есть возможность сменить тему в редакторе. Доступные темы находятся тут.
		И Я делаю подсветку элемента формы VA по имени "ГруппаVanessaEditorВыборТемы" "Смена темы"
		И Пауза 0.1
		И я делаю клик по элементу формы VA UI Automation 'ЭтотСеанс' 'ГруппаVanessaEditorВыборТемы'
		И Пауза 0.1

	* Вы можете выбрать ту тему, которая вам нравится и сохранить настройки.
	* Для примера выберем тёмную тему.
		И Я делаю подсветку элемента VA "VanessaEditorТема_vsdark" "Темная тема" и перемещаю курсор
		И Пауза 0.1
		И я делаю клик по элементу формы VA UI Automation 'ЭтотСеанс' 'VanessaEditorТема_vsdark'
		И Пауза 0.1

	* На этом всё, переходи к следующему уроку интерактивной справки.



