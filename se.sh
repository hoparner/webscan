#!/bin/bash

# Цвета для улучшения визуальной читаемости
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Проверка, установлен ли Nikto, и установка, если он не установлен
check_installation() {
    if ! command -v nikto &>/dev/null; then
        echo -e "${RED}Nikto не установлен.${NC}"
        echo -e "${GREEN}Установка Nikto...${NC}"
        sudo apt-get update
        sudo apt-get install -y nikto
        echo -e "${GREEN}Nikto успешно установлен.${NC}"
    fi
}

scan_vulnerabilities() {
    nikto -h "$1"
}

# Функция для сохранения результатов сканирования в файл
save_results() {
    local filename="$1.txt"
    echo -e "${GREEN}Сохранение результатов сканирования в файл: $filename${NC}"
    nikto -h "$1" -o "$filename"
    echo -e "${GREEN}Результаты сканирования сохранены в файл: $filename${NC}"
}

# Основной интерфейс скрипта
echo -e "${GREEN}Добро пожаловать в скрипт сканирования уязвимостей веб-сайтов!${NC}"
echo -e "${GREEN}Выберите действие:${NC}"
echo "1. Выполнить сканирование уязвимостей"
echo "2. Выполнить сканирование уязвимостей и сохранить результаты в файл"
echo "3. Выйти"

read choice

case $choice in
    1)
        check_installation
        echo -e "${YELLOW}Введите URL веб-сайта для сканирования:${NC}"
        read url
        scan_vulnerabilities "$url"
        ;;
    2)
        check_installation
        echo -e "${YELLOW}Введите URL веб-сайта для сканирования:${NC}"
        read url
        scan_vulnerabilities "$url"
        save_results "$url"
        ;;
    3)
        echo -e "${GREEN}Выход${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED}Неверный выбор${NC}"
        exit 1
        ;;
esac
