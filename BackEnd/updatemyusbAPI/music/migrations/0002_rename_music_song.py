# Generated by Django 4.2.10 on 2024-02-27 18:27

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0002_user_is_dj_user_is_provider_musicprovider_dj'),
        ('music', '0001_initial'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='Music',
            new_name='Song',
        ),
    ]
