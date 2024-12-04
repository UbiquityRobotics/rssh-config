FROM nginx:alpine
WORKDIR /etc/nginx
COPY . .
RUN mkdir -p /var/www/rose.ubiquityrobotics.com/ && mv public /var/www/rose.ubiquityrobotics.com/
RUN chown -R nginx:nginx /var/www/rose.ubiquityrobotics.com/
