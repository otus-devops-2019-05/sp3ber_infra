# sp3ber_infra
Репозиторий "Инфраструктура как код" для курса OTUS DevOps для группы 2019-05

[![Build Status](https://travis-ci.com/otus-devops-2019-05/sp3ber_infra.svg?branch=master)](https://travis-ci.com/otus-devops-2019-05/sp3ber_infra)

## Домашние задания
[Настройка локального окружения и практика ChatOps](#local_settings_chatops)

[Знакомство с облачной инфраструктурой. Google Cloud Platform](#gcp_introduction)

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

