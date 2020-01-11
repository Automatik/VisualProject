#!/usr/bin/python
# -*- coding: utf-8 -*-
from Updater import Updater
import os
import sys
import platform
import subprocess
import matlab.engine
import time

def fileparts(fn):
	(dirName, fileName) = os.path.split(fn)
	(fileBaseName, fileExtension) = os.path.splitext(fileName)
	return (dirName, fileBaseName, fileExtension)


def imageHandler(
	bot,
	message,
	chat_id,
	local_filename,
	):
	print(local_filename)
	
	# send message to user

	bot.sendMessage(chat_id, 'Attendere, sto cercando i prodotti più simili...')

	# set matlab command

	if 'Linux' in platform.system():
		matlab_cmd = '/usr/local/bin/matlab'
	else:
		matlab_cmd = \
			'"C:\\Program Files\\MATLAB\\R2019a\\bin\\matlab.exe"'

	# cur_dir = \
	# 	'"C:\\Users\\MatteoPelucchi\\Desktop\\Progetto4\\VisualProject"'
	# cmd = matlab_cmd \
	# 	+ ' -nodesktop -nosplash -nodisplay -wait -r "addpath(\'' \
	# 	+ cur_dir + "\');imagePath=\'" + local_filename \
	# 	+ '\'; getSimilarItems; quit"'
	#
	# subprocess.call(cmd, shell=True)
	eng.workspace['imagePath'] = local_filename
	eng.getSimilarItems(nargout=0)
	(dirName, fileBaseName, fileExtension) = fileparts(local_filename)
	bot.sendMessage(chat_id, 'Ecco i dieci prodotti più simili che ho trovato:')
	for i in range(1, 11):
		new_fn = os.path.join(dirName, fileBaseName + '_' + str(i)
							+ fileExtension)
		bot.sendImage(chat_id, new_fn, '')
	bot.sendMessage(chat_id, 'Sono pronto a ricevere una nuova immagine')
if __name__ == '__main__':
	bot_id = '1033098410:AAGhkngtsmD_EqOmCMnkt1LfGXCl4gyZNIw'
	matlab_cmd = \
		'"C:\\Program Files\\MATLAB\\R2019a\\bin\\matlab.exe"'
	#subprocess.call(matlab_cmd, shell=True)
	subprocess.Popen('matlab -sd "C:\\Users\\MatteoPelucchi\\Desktop\\Progetto4\\VisualProject" -r "matlab.engine.shareEngine(\'Bot\')"', shell=True)
	time.sleep(10)
	#names = matlab.engine.find_matlab()
	#eng = matlab.engine.connect_matlab(str(names[0]))
	eng = matlab.engine.connect_matlab('Bot')
	updater = Updater(bot_id, eng)
	updater.setPhotoHandler(imageHandler)
	updater.start()

			