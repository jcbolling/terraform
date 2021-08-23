resource "aws_db_subnet_group" "default" {
    name       = "db_main"
    subnet_ids = [aws_subnet.bn_test_private_subnet_01.id, aws_subnet.bn_test_private_subnet_02.id]

    tags = {

        name = "Main DB subnet group"
    }
}

resource "aws_db_instance" "bn_test_mysql_db" {

    allocated_storage        = 5
    engine                   = "mysql"
    engine_version           = "5.7"
    instance_class           = "db.t2.micro"
    name                     = "wordpress"
    username                 = var.db_username
    password                 = var.db_password
    db_subnet_group_name     = aws_db_subnet_group.default.name
    vpc_security_group_ids   = [aws_security_group.bn_test_sg_3306_from_private_to_rds.id]
    skip_final_snapshot      = true

}