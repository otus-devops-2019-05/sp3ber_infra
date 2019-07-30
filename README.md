# sp3ber_infra

Репозиторий "Инфраструктура как код" для курса OTUS DevOps для группы 2019-05

[![Build Status](https://travis-ci.com/otus-devops-2019-05/sp3ber_infra.svg?branch=master)](https://travis-ci.com/otus-devops-2019-05/sp3ber_infra)

## Домашние задания

[Настройка локального окружения и практика ChatOps](#local_settings_chatops)

[Знакомство с облачной инфраструктурой. Google Cloud Platform](#gcp_introduction)

[Деплой тестового приложения](#deploy_testapp)

[Сборка образов VM с помощью Packer](#packer_vm)

[Практика IaC с использованием Terraform](#terraform_iac_1)

[Принципы организации инфраструктурного кода и работа над инфраструктурой в команде на примере Terraform](#terraform_iac_2)

[Знакомство с ansible](#ansible_1)

[Расширенные возможности Ansible](#ansible_2)

[Работа с ролями и окружениями в Ansible](#ansible_3)

[Разработкаитестирование Ansible ролей и плейбуков](#ansible_4)

<a name="local_settings_chatops"><h4>Настройка локального окружения</h4></a>

<h5>Что сделано</h3>

    * Добавлен шаблон для github pull requests
    * Добавлен файл настроек для Travis CI
    * Добавлен и исправлен unit тест на python

<a name="#gcp_introduction"><h4>Знакомство с облачной инфраструктурой. Google Cloud Platform</h4></a>

<h5>Что сделано</h3>

    * Найдена команда для подключения к someinternalhost по ssh в одну команду
    ssh -J <username>@<bastion_external_ip> <username@<someinternalhost_internal_ip>

    * Найден способ подключения по алиасу через правку ssh config c использованием ProxyCommand.

    Содержание конфига .ssh/config:

    Host bastion
    Hostname <bastion_internal_ip>
    User <username>

    Host someinternalhost
    ProxyCommand ssh -q bastion nc -q0 <someinternalhost_internal_ip>

    * Конфигурационные данные для проверки дз в небходимом формате:
    bastion_IP = 34.77.32.152
    someinternalhost_IP = 10.132.0.3

<a name="#deploy_testapp"><h4>Деплой тестового приложения</h4></a>

<h5>Что сделано</h3>

    * Создан инстанс вм с помощью gcloud
    * Установлен ruby на указанном хосте
    * Установлена и запущена mongodb
    * Задеплоено тестовое приложение
    * Команды установки mongo, ruby и деплоя тестового приложения вынесены в отдельные скрипты
    * Вынес создание ВМл в отдельный скрипт (create_vm_with_startup.sh) с указанием startup_script
    * Вынес создание правила firewall в отдельный скрипт (create_firewall_rule.sh)

    * Конфигурационные данные для проверки дз в небходимом формате:
    testapp_IP = 104.199.23.174
    testapp_port = 9292

    * Создать ВМ с указанием startup.script:
    ./create_vm.sh

    * Создать правило firewall:
    ./create_firewall_rule.sh

<a name="#packer_vm"><h4>Сборка образов VM с помощью Packer</h4></a>

<h5>Что сделано</h3>

    * Создан шаблон для packer для образа reddit-base
    * Создан образ vm на основе шаблона в GCP
    * Добавлены пользовательские переменные в шаблон Packer
    * Добавлен и проверен скрипт создания инстанса на основе образа reddit-base в GCP

<a name="#terraform_iac_1"><h4>Практика IaC с использованием Terraform</h4></a>

<h5>Что сделано</h3>

    * Созданы конфигурационные файлы для terraform
    * Вынесены в отдельный файл переменные для конфигурационных файлов terraform
    * Добавлен шаблон с пользовательскими переменными
    * Конфигурация провалидирована, проверено создание необходимой инфраструктуры в GCP

<a name="#terraform_iac_2"><h4>Принципы организации
инфраструктурного
кода и работа над
инфраструктурой в
команде на примере
Terraform.</h4></a>

<h5>Что сделано</h3>

    * созданы модули app, db, vpc, storage-bucket
    * созданы отдельные конфигурации для stage, prod
    * созданы дополнительные шаблоны VM для packer (приложение разделено на два отдельных образа)
    * попрактиковался с параметризацией модулей Terraform, создании модуля (vpc), использовании существующего в реестре модуля (storage-bucket)

<a name="#ansible_1"><h4>Знакомство с ansible</h4></a>

<h5>Что сделано</h3>

    * использованы команды ansible - ping, command, shell, а также использование модулей git и service
    * создан простой плейбук
    * проверен запуск плейбука после удаления папки с проектом на хосте app. При повторном запуске плейбука отображается и подсвечивается статус "changed=1" (т.е. одно изменение)
    * для использования json inventory динамической схемы испльзуем скрипт inventory.sh, который при вызове с аргументом --list просто выводит содержимое файла inventory.json
    * выяснил разницу между схемой json для динамического inventory и статического:
    главное, что в динамическом хосты - это массивы,
    а в статическом - это словари, где ключ - это адрес хоста, а значение - null
    
<a name="#ansible_2"><h4>Расширенные возможности Ansible</h4></a>

<h5>Что сделано</h3>

    * Использовал плейбуки, хендлеры и шаблоны для конфигурации окружения и деплоя тестового приложения.
    * Попробовал подход - один плейбук, один сценарий (play)
    * Попробовал подход - один плейбук, но много сценариев
    * Попробовал подход - много плейбуков
    * Изменил провижн образов Packer на Ansible-плейбуки

<a name="#ansible_3"><h4>Работа с ролями и окружениями в Ansible</h4></a>

<h5>Что сделано</h3>

    * Перенес созданные плейбуки в раздельные роли
    * Описал два окружения
    * Использовал коммьюнити роль nginx
    * Использовал Ansible Vault для наших окружений
    
<a name="#ansible_4"><h4>Разработкаитестирование Ansible ролей и плейбуков</h4></a>

<h5>Что сделано</h3>
    * Доработал роли для провижининга в Vagrant
    * Протестировал роли при помощи Molecule и ﻿Testinfra
    * Переключил сбор образов пакером на использование ролей
