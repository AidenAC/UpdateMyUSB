# Generated by Django 4.2.10 on 2024-02-27 16:57

from django.conf import settings
import django.core.validators
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='is_dj',
            field=models.BooleanField(default=False),
        ),
        migrations.AddField(
            model_name='user',
            name='is_provider',
            field=models.BooleanField(default=False),
        ),
        migrations.CreateModel(
            name='MusicProvider',
            fields=[
                ('providerid', models.AutoField(primary_key=True, serialize=False)),
                ('providername', models.CharField(max_length=255)),
                ('providertype', models.IntegerField(default=1, validators=[django.core.validators.MaxValueValidator(3), django.core.validators.MinLengthValidator(1)])),
                ('email', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='DJ',
            fields=[
                ('djid', models.AutoField(primary_key=True, serialize=False)),
                ('djname', models.CharField(max_length=255)),
                ('email', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
