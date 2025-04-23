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
    cd /var/www/html
    echo '<html><head><title>Cat</title></head> <body><h1>Hello!</h1><img src="http://s3bucket2.website.yandexcloud.net/cat"/></body></html>' > index.html
    EOF
    }
}



