# Домашнее задание к занятию «Безопасность в облачных провайдерах»  

Используя конфигурации, выполненные в рамках предыдущих домашних заданий, нужно добавить возможность шифрования бакета.

---
## Задание 1. Yandex Cloud   

1. С помощью ключа в KMS необходимо зашифровать содержимое бакета:

 - создать ключ в KMS;
 - с помощью ключа зашифровать содержимое бакета, созданного ранее.
2. (Выполняется не в Terraform)* Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS:

 - создать сертификат;
 - создать статическую страницу в Object Storage и применить сертификат HTTPS;
 - в качестве результата предоставить скриншот на страницу с сертификатом в заголовке (замочек).

Полезные документы:

- [Настройка HTTPS статичного сайта](https://cloud.yandex.ru/docs/storage/operations/hosting/certificate).
- [Object Storage bucket](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/storage_bucket).
- [KMS key](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kms_symmetric_key).

### Ответ
1. Создадим все необходимые манифесты. 

[balance.tf](https://github.com/ne0kk/YandexCloud/blob/main/03/balance.tf)

[count-vm-public.tf](https://github.com/ne0kk/YandexCloud/blob/main/03/count-vm-public.tf)

[images.jpg](https://github.com/ne0kk/YandexCloud/blob/main/03/images.jpg)

[local.tf](https://github.com/ne0kk/YandexCloud/blob/main/03/local.tf)

[main.tf](https://github.com/ne0kk/YandexCloud/blob/main/03/main.tf)

[outputs.tf](https://github.com/ne0kk/YandexCloud/blob/main/03/outputs.tf)

[providers.tf](https://github.com/ne0kk/YandexCloud/blob/main/03/providers.tf)

[s3_backet.tf](https://github.com/ne0kk/YandexCloud/blob/main/03/s3_backet.tf)

[var.s3.tf](https://github.com/ne0kk/YandexCloud/blob/main/03/var.s3.tf)

[vars.network.tf](https://github.com/ne0kk/YandexCloud/blob/main/03/vars.network.tf)

[vars.providers.tf](https://github.com/ne0kk/YandexCloud/blob/main/03/vars.providers.tf)

[vars.vm.tf](https://github.com/ne0kk/YandexCloud/blob/main/03/vars.vm.tf)

Запустим террформ. 
![image](https://github.com/user-attachments/assets/1533397d-be3a-4df4-a5e7-686479e2d495)

Убедимся что все поднялось. 
![image](https://github.com/user-attachments/assets/7b07e8bb-10ef-4d61-9012-24120e53a818)

Проверим доступность балансировщика
![image](https://github.com/user-attachments/assets/fbe6e87c-27d2-4c9c-9fb5-bf529bee2f9b)
![image](https://github.com/user-attachments/assets/cafc260e-ea43-45dc-9236-4fe28e0d18dd)
Картинка не доступна. 

Проверим шифрование 
![image](https://github.com/user-attachments/assets/ac57fd3b-6726-42a1-8d79-8c5e6a4003df)

![image](https://github.com/user-attachments/assets/cfa7119f-5596-4757-aa42-491ac74914de)

Фаил зашифрован. 
