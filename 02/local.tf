locals{
    metadata_pub = {
        ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
    metadata_priv = {
        ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
    metadata_user_data = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    serial-port-enable = "1"
    user-data  = <<EOF
    #!/bin/bash
    cd /var/www/html
    echo '<html><head><title>Dragon</title></head> <body><h1>Hello!</h1><img src="https://storage.yandexcloud.net/homework-s3/images.jpg"/></body></html>' > index.html
    EOF
    }
}



