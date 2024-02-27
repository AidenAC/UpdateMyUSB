# Generated by Django 4.2.10 on 2024-02-27 18:36

import django.core.validators
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0002_user_is_dj_user_is_provider_musicprovider_dj'),
    ]

    operations = [
        migrations.AlterField(
            model_name='musicprovider',
            name='providertype',
            field=models.IntegerField(default=[1], validators=[django.core.validators.MaxValueValidator(3), django.core.validators.MinLengthValidator(1)]),
        ),
    ]
