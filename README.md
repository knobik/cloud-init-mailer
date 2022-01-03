# Just a Cloud-init Mailer

Uses the `phone home` module to email you when cloud-init finishes its job.

Run

```bash
docker run -d -p 80:8000 -e MAIL_TO=[WHERE_TO_SEND_NOTIFICATIONS] MAIL_USERNAME=[YOUR_SMTP_LOGIN] -e MAIL_PASSWORD=[YOUR_SMTP_PASSWORD] knobik/cloud-init-mailer:latest
```

default env values:

```dotenv
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=465
MAIL_USERNAME=
MAIL_PASSWORD=
MAIL_ENCRYPTION=ssl
MAIL_FROM_ADDRESS="${MAIL_USERNAME}"
MAIL_FROM_NAME="${APP_NAME}"
MAIL_TO=
```

custom mail template (based on laravel blade):
```yaml
-v your-template.blade.php:/app/resources/views/mails/init-finished.blade.php
```

```html
<div>
    <p>
        Host called home with data:
    </p>
    <p>
        Host: {{ $hostname }}<br />
        IP: {{ $ip }}
    </p>
</div>
```

cloud-init datasource example

```yaml
phone_home:
  url: http://your-server-hosting-this:8080/api/notify
  post:
   - hostname
  tries: 3
  ```
