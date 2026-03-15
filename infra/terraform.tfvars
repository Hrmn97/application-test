vpc_id                = "vpc-01b6cee90c3a3ad67"
private_subnet_ids    = ["subnet-08b58d92473926195", "subnet-03537e6a7f5075dcd"]
ecs_cluster_id        = "arn:aws:ecs:us-west-2:127424156127:cluster/prod-notification"
alb_arn               = "arn:aws:elasticloadbalancing:us-west-2:127424156127:loadbalancer/app/prod-notification-alb/33810cb07b4b009a"
alb_listener_arn      = "arn:aws:elasticloadbalancing:us-west-2:127424156127:listener/app/prod-notification-alb/33810cb07b4b009a/bc1fb2038c181e8b"
alb_security_group_id = "sg-0b82ae84b70edcc71"
mongodb_secret_arn    = "arn:aws:secretsmanager:us-west-2:127424156127:secret:prod/app/ecs/notifications-lZaKlG"