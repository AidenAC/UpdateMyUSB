# Generated by Django 4.2.10 on 2024-04-05 15:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0004_alter_musicprovider_providertype'),
        ('music', '0006_song_djs'),
    ]

    operations = [
        migrations.AlterField(
            model_name='song',
            name='djs',
            field=models.ManyToManyField(blank=True, related_name='songs', to='users.dj'),
        ),
    ]