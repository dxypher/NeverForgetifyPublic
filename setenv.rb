# The name of this business, as displayed to your users throughout the application
ENV['BUSINESS_NAME']="KohCMS"
# the from address used when sending email to customers, and also the email address we send admin emali to (e.g. from the conact form)
ENV['BUSINESS_EMAIL']="nikhil@kohactive.com"

# used for facebook connect, google analytics, emails and other places where a master domain name is used to represent the business
ENV['BASE_DOMAIN_NAME']="kohactive.com"


ENV['DATABASE_NAMESPACE']="never_forgetify"
# mysql usernme and password
ENV['MYSQL_USERNAME']="neverforget"
ENV['MYSQL_PASSWORD']="ywTmNTkJKZ5Cy6hbzhjVt7nH"
ENV['MYSQL_HOST']="localhost"

ENV['MYSQL_PORT']="3306"


# emails sent in development are intercepted and delivered to the developer, so we dont bombard customers by accident
ENV['DEVELOPER_EMAIL']="nikhil@kohactive.com"



ENV['YOUTUBE_DEV_KEY']=""
ENV['TWILIO_SID']="ACd7a86d0e5b3f36a33684399abcc7016e"
ENV['TWILIO_TOKEN']="36663100dd7cacf2f4afeefc2113f904"
ENV['TWILIO_NUMBER']="+18722210479"
