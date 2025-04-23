# Домашнее задание к занятию «Вычислительные мощности. Балансировщики нагрузки»  

### Подготовка к выполнению задания

1. Домашнее задание состоит из обязательной части, которую нужно выполнить на провайдере Yandex Cloud, и дополнительной части в AWS (выполняется по желанию). 
2. Все домашние задания в блоке 15 связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
3. Все задания нужно выполнить с помощью Terraform. Результатом выполненного домашнего задания будет код в репозитории. 
4. Перед началом работы настройте доступ к облачным ресурсам из Terraform, используя материалы прошлых лекций и домашних заданий.

---
## Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать бакет Object Storage и разместить в нём файл с картинкой:

 - Создать бакет в Object Storage с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать файл доступным из интернета.
 
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

 - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.
 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
 - Настроить проверку состояния ВМ.
 
3. Подключить группу к сетевому балансировщику:

 - Создать сетевой балансировщик.
 - Проверить работоспособность, удалив одну или несколько ВМ.
4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.

Полезные документы:

- [Compute instance group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance_group).
- [Network Load Balancer](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer).
- [Группа ВМ с сетевым балансировщиком](https://cloud.yandex.ru/docs/compute/operations/instance-groups/create-with-balancer).

### Ответ
1. Создадим все необходимые манифесты для выполнения ДЗ
[balance.tf](https://github.com/ne0kk/YandexCloud/blob/main/02/balance.tf)
[count-vm-public.tf](https://github.com/ne0kk/YandexCloud/blob/main/02/count-vm-public.tf)
[local.tf](https://github.com/ne0kk/YandexCloud/blob/main/02/local.tf)
[main.tf](https://github.com/ne0kk/YandexCloud/blob/main/02/main.tf)
[outputs.tf](https://github.com/ne0kk/YandexCloud/blob/main/02/outputs.tf)
[providers.tf](https://github.com/ne0kk/YandexCloud/blob/main/02/providers.tf)
[s3_backet.tf](https://github.com/ne0kk/YandexCloud/blob/main/02/s3_backet.tf)
[var.s3.tf](https://github.com/ne0kk/YandexCloud/blob/main/02/var.s3.tf)
[vars.network.tf](https://github.com/ne0kk/YandexCloud/blob/main/02/vars.network.tf)
[vars.providers.tf](https://github.com/ne0kk/YandexCloud/blob/main/02/vars.providers.tf)
[vars.vm.tf](https://github.com/ne0kk/YandexCloud/blob/main/02/vars.vm.tf)  

2. Запустим создание ресурсов
   
![image](https://github.com/user-attachments/assets/6c6b5970-4678-4f78-85ee-fb64bf0ef664)

![image](https://github.com/user-attachments/assets/12e79f4c-791e-4b77-8f8b-ff0cabcad04c)

![image](https://github.com/user-attachments/assets/a4e1e1ec-35a7-406b-b86b-81fa830c8384)

![image](https://github.com/user-attachments/assets/738a354b-0ec4-43aa-991e-4aeeafea35e2)

3. Проверим доступность веб сервера с измененной картинкой по IP балансировщика.

![image](https://github.com/user-attachments/assets/04c10d73-0b54-47be-a05a-2b9e5cee8aa2)

4. Проверим работу балансировщика, отключим 2 ВМ из 3.
 
![image](https://github.com/user-attachments/assets/65882b84-c2e6-430f-b5d6-7be37123f883)

IP адресс балансировщика отвечает 

![image](https://github.com/user-attachments/assets/35c3aee9-1747-41b1-8608-ba6e19725bf6)

Проверим работу групп доступности при отключенных 2 ВМ

![image](https://github.com/user-attachments/assets/e53fb4d0-4366-4b70-8323-b7404046d329)

Группа подняла ВМ

![image](https://github.com/user-attachments/assets/8e820b7d-b47c-4342-bb31-913e27e734ab)

![image](https://github.com/user-attachments/assets/a9fa5f84-abdf-42c4-a6c0-5caa4cf23813)
