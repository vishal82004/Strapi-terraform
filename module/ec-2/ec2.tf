resource "aws_instance" "web" {
    
    count         = length(module.vpc.public_subnet_ids)
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = module.vpc.public_subnet_ids[count.index]
    tags = {
        Name = var.instance_name
    }
    associate_public_ip_address = var.associate_public_ip

    key_name                    = var.key_name

    vpc_security_group_ids = [
        module.rds.ec2_sg
    ]
  # Attach the IAM instance profile
  iam_instance_profile = module.s3.ec2_profile_name 

    user_data = <<-EOF
                #!/bin/bash
                set -e # Exit on any error

                # Update packages and install dependencies
                sudo apt-get update -y
                sudo apt-get install -y git yarn

                # Install NVM (Node Version Manager) and Node.js
                curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
                export NVM_DIR="$HOME/.nvm"
                [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
                nvm install 16
                nvm use 16

                # Clone your Strapi project (replace with your actual repo URL)
                git clone https://github.com/your-username/your-strapi-repo.git /srv/strapi
                cd /srv/strapi

                # Create the .env file for Strapi
                cat <<EOT > .env
                HOST=0.0.0.0
                PORT=1337
                
                # Security Keys
                AWS_BUCKET=${var.s3_bucket_name}
                AWS_SIGNED_URL_EXPIRATION=${var.AWS_SIGNED_URL_EXPIRATION}
                AWS_ACL=${var.AWS_ACL}
                AWS_REGION=${var.aws_region}
                AWS_ACCESS_KEY_ID=${module.s3.access_key}
                AWS_SECRET_ACCESS_KEY=${module.s3.secret_key}


                # Database Connection
                DATABASE_CLIENT=postgres
                DATABASE_HOST=${var.rds_endpoint}
                DATABASE_PORT=5432
                DATABASE_NAME=strapi
                DATABASE_USERNAME=${var.rds_username}
                DATABASE_PASSWORD=${var.rds_password}
                
                # S3 Upload Provider
                AWS_REGION=${var.aws_region}
                AWS_BUCKET=${var.s3_bucket_name}
                EOT
                yarn add @strapi/provider-upload-aws-s3
                # Create the plugins.js file for S3 provider
                mkdir -p config
                cat <<EOT > config/plugins.js
                module.exports = ({ env }) => ({
                  upload: {
                    config: {
                      provider: 'aws-s3',
                      providerOptions: {
                        s3Options: {
                          region: env('AWS_REGION'),
                          params: {
                            Bucket: env('AWS_BUCKET'),
                          },
                        },
                      },
                      actionOptions: {
                        upload: {},
                        uploadStream: {},
                        delete: {},
                      },
                    },
                  },
                });
                EOT

                # Install dependencies and build the Strapi app
                yarn install
                yarn build

                # Start the Strapi application (use a process manager like pm2 in a real production setup)
                yarn start
                EOF 
    
}                
resource "aws_key_pair" "deployer_key" {
  key_name   = var.key_name
  public_key = var.public_key
  
}