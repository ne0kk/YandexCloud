# Домашнее задание к занятию «Организация сети»

### Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.

 - Создать в VPC subnet с названием public, сетью 192.168.10.0/24.
 - Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1.
 - Создать в этой публичной подсети виртуалку с публичным IP, подключиться к ней и убедиться, что есть доступ к интернету.
3. Приватная подсеть.
 - Создать в VPC subnet с названием private, сетью 192.168.20.0/24.
 - Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс.
 - Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее, и убедиться, что есть доступ к интернету.

Resource Terraform для Yandex Cloud:

- [VPC subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet).
- [Route table](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table).
- [Compute Instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance).


---
### Ответ:
1. создадим необходимые манифесты для terraform.
[count-vm-private.tf](https://github.com/ne0kk/YandexCloud/blob/main/01/count-vm-private.tf)

[count-vm-public.tf](https://github.com/ne0kk/YandexCloud/blob/main/01/count-vm-public.tf)

[local.tf](https://github.com/ne0kk/YandexCloud/blob/main/01/local.tf)

[outputs.tf](https://github.com/ne0kk/YandexCloud/blob/main/01/outputs.tf)

[providers.tf](https://github.com/ne0kk/YandexCloud/blob/main/01/providers.tf)

[vars.network.tf](https://github.com/ne0kk/YandexCloud/blob/main/01/vars.network.tf)

[vars.providers.tf](https://github.com/ne0kk/YandexCloud/blob/main/01/vars.providers.tf)

[vars.vm.tf](https://github.com/ne0kk/YandexCloud/blob/main/01/vars.vm.tf)

Пропишем создание сети и подсетейв ней, добавим таблицу маршрутизации и статический маршрут перенаправляющий трафик на инстанс с натом 
[main.tf](https://github.com/ne0kk/YandexCloud/blob/main/01/main.tf)

Запустим terraform, проверим выполнение. 
![image](https://github.com/user-attachments/assets/f2b91e99-a4e6-4de0-9738-f14345c1a9a1)

Проверим созданные ресурсы в интерфейсе. 

![image](https://github.com/user-attachments/assets/26ded654-f7c2-4f02-92cf-7b41736cb4a0)
![image](https://github.com/user-attachments/assets/bf1f5bea-1053-44c8-a081-050cd5287ab5)
![image](https://github.com/user-attachments/assets/da8af2e8-ab2e-480d-a376-774037330385)

Убедимся что приватной машине не выдан внешний IP и отключен NAT

![image](https://github.com/user-attachments/assets/83378b39-e153-434d-9ca9-fece257432ba)

Подключимся к машине с NAT проверим наличие доступа в интернет

![image](https://github.com/user-attachments/assets/7d7957c4-9dcd-4576-9485-cb3ba4414d3d)

Подключимся к машине в приватной сети по локальному адресу и проверим доступность интернета

![image](https://github.com/user-attachments/assets/82edace1-11a0-4ed2-841a-fce11eeee281)

Удалим статический маршурт и проверим доступность интернета

![image](https://github.com/user-attachments/assets/b302045b-cb74-4d1b-b7c5-f1bee1dd18a0)

Интернет пропал 

![image](https://github.com/user-attachments/assets/2b8ec54d-19d9-40b7-bac5-c511292c2936)




