# Canteen-Bot


## Telegram-бот для просмотра актуального меню столовых НИТУ МИСИС
Данный бот позволяет студентам просматривать меню столовых, выбирая категорию (завтрак, горячее, гарнир и т.д.)
Бот имеет отдельный интерфейс для студента и администратора. Для запуска используйте команду /start.
С помощью интерактивной клавиатуры выберите роль: <br />
![image](https://user-images.githubusercontent.com/90785698/208379496-3c75ec0c-7012-44d7-b88a-5651dc1bf8c3.png) <br />
Бот выводит информацию о блюдах и ценах: <br />
![image](https://user-images.githubusercontent.com/90785698/208379723-6e5e7e40-5da9-4cde-92b5-1ff9ce8106a1.png) <br />
Вход в роли администратора осуществляется по паролю. Функционал администратора включает в себя добавление нового блюда, очистку меню и добавление блюда в текущее меню:<br />
![image](https://user-images.githubusercontent.com/90785698/208380017-519ca063-04f1-4d05-97a1-6243a02035f1.png) <br />

Бот реализован с помощью библиотеки tgbot-cpp с использованием встраиваемой базы данных Sqlite

# Установка проекта
Инструкция по сборке
## Установка зависимостей
Windows
1.	Для установки необходим пакетный менеджер vcpkg. Для установки vcpkg перейдите в корневую папку и клонируйте репозиторий с помощью команды git clone https://github.com/microsoft/vcpkg в выбранную папку.
2.	Далее выполните команду  .\vcpkg\bootstrap-vcpkg.bat
3.	Чтобы использовать vcpkg с Visual Studio запустите команду .\vcpkg integrate install
4.	Для установки библиотеки tgbot и ее зависимостей на Windows-x64 используйте следующую команду .\vcpkg install tgbot-cpp:x64-windows. Установка займет некоторое время.
5.	Для установки tgbot и ее зависимостей на Windows -x86 используйте команду .\vcpkg install tgbot-cpp
6.	Для установки библиотеки  sqlite3 на Windows-x64 используйте команду .\vcpkg install sqlite3:x64-windows
7.	 Для установки библиотеки  sqlite3 на Windows-x86 используйте команду .\vcpkg install sqlite3


## Linux
1.	Для установки зависимостей используйте следующие команды
sudo apt-get install g++ make binutils cmake libboost-system-dev libssl-dev zlib1g-dev libcurl4-openssl-dev libsqlite3-dev  
2.	Для компиляции и установки используйте  
git clone https://github.com/reo7sp/tgbot-cpp  
cd tgbot-cpp  
cmake .  
make -j4  
sudo make install  

## MacOS  
1.	Для установки зависимостей используйте следующие команды  
	brew install gcc cmake boost openssl zlib curl sqlite3  
       2.  Для компиляции и установки используйте  
git clone https://github.com/reo7sp/tgbot-cpp  
cd tgbot-cpp  
cmake .  
make -j4  
sudo make install  
