#!/usr/bin/python
# -*- coding: utf-8 -*-
import logging
import time
import json
import os
import sys
import urllib
import tempfile
import requests
from Bot import Bot
import subprocess

def doNothing(*arg):
	pass


class Updater:

	def __init__(
		self,
		bot_id,
		eng,
		waitingTime=0,
		download_folder=tempfile.gettempdir() + os.sep,
		):
		self.bot = Bot(bot_id, download_folder)
		self.textHandler = doNothing
		self.photoHandler = doNothing
		self.voiceHandler = doNothing
		self.documentHandler = doNothing
		self.waitingTime = waitingTime
		self.eng = eng
		self.textOld = ""

	def setTextHandler(self, f):
		self.textHandler = f

	def setPhotoHandler(self, f):
		self.photoHandler = f

	def setVoiceHandler(self, f):
		self.voiceHandler = f

	def start(self):
		while True:
			for u in self.bot.getUpdates():

				# get info about the message

				messageType = self.bot.getMessageType(u['message'])
				message = u['message']
				chat_id = message['chat']['id']
				name = message['chat']['first_name']
				message_id = message['message_id']

				# call right functors

				if messageType == 'text':

					# TODO: distinguish between command and plain text

					text = message['text']
					if text == '/start':
						if (self.eng.eval('exist("svmArticle")')):
							self.bot.sendMessage(chat_id,
												 "Ciao, sono fashion VIPM bot, sono pronto a ricevere in input l'immagine")
						else:
							self.bot.sendMessage(chat_id,
												 "Ciao, sono fashion VIPM bot, attendere il caricamento dei modelli...")
							self.eng.preload(nargout=0)
							self.bot.sendMessage(chat_id,
												 "Caricamento terminato, sono pronto a ricevere in input l'immagine")
					elif text == '/reload':
						self.textOld = text
						self.bot.sendMessage(chat_id,
								'Sei sicuro di voler ricaricare i modelli? Digita si per ricaricare oppure no per annullare')
					elif ((text == 'si' or text == 'Si' or text == 'SI') and self.textOld == "/reload"):
						self.textOld = ""
						self.bot.sendMessage(chat_id,
								'Attendere il caricamento dei modelli...')
						self.eng.preload(nargout=0)
						self.bot.sendMessage(chat_id,
								"Caricamento terminato, sono pronto a ricevere in input l'immagine")
					elif ((text == 'no' or text == 'No' or text == 'NO') and self.textOld == "/reload"):
						self.textOld = ""
						self.bot.sendMessage(chat_id,
											 "Sono pronto a ricevere in input l'immagine")
				if messageType == 'photo':
					local_filename = self.bot.getFile(u['message'
							]['photo'][-1]['file_id'])
					self.photoHandler(self.bot, message, chat_id,
							local_filename)
				if messageType == 'voice':
					local_filename = self.bot.getFile(u['message'
							]['voice']['file_id'])
					self.voiceHandler(self.bot, message, chat_id,
							local_filename)
				if messageType == 'document':
					local_filename = self.bot.getFile(u['message'
							]['document']['file_id'])
					self.documentHandler(self.bot, message, chat_id,
							local_filename)
			if self.waitingTime > 0:
				time.sleep(self.waitingTime)


if __name__ == '__main__':
	updater = Updater('128366843:AAHovviK9AQDbcWJkM9JkqDAt8B5oLUUCQI')
	updater.start()


