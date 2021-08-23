resource "aws_db_instance" "bn_test_mysql_db" {

    allocated_storage   = 5
    engine              = "mysql"
    engine_version      = "5.7"
    instance_calss      = "db.t2.micro"
    name                = "wordpress"
    username            = var.db_username
    password            = var.db_password
    skip_final_snapshot = true
    
}