locals{
    metadata_pub = {
        ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
    metadata_priv = {
        ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
}



