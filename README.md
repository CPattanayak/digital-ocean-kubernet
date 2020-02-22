# digital-ocean-kubernet
This project provision a kubernet cluster on digital ocean with jenkin server and ngnx loadbalancer
 1.to provision cluster terraform apply -auto-approve -var do_token=<token>
 2.to destroy cluster terraform destroy -auto-approve -var do_token=<token>