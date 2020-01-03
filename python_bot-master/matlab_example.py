from Updater import Updater
import os, sys, platform, subprocess

def fileparts(fn):
    (dirName, fileName) = os.path.split(fn)
    (fileBaseName, fileExtension) = os.path.splitext(fileName)
    return dirName, fileBaseName, fileExtension


def imageHandler(bot, message, chat_id, local_filename):
	print(local_filename)
	# send message to user
	bot.sendMessage(chat_id, "Hi, please wait until the image is ready")
	# set matlab command
	if 'Linux' in platform.system():
		matlab_cmd = '/usr/local/bin/matlab'
	else:
		matlab_cmd = '"C:\\Program Files\\MATLAB\\R2019a\\bin\\matlab.exe"'
	# set command to start matlab script "edges.m"
	# cur_dir = os.path.dirname(os.path.realpath(__file__))
	cur_dir = '"C:\\Users\\MatteoPelucchi\\Desktop\\Progetto4\\VisualProject"'
	cmd = matlab_cmd + " -nodesktop -nosplash -nodisplay -wait -r \"addpath(\'" + cur_dir + "\'); getSimilarItems(\'" + local_filename + "\'); quit\""
	# lunch command
	subprocess.call(cmd,shell=True)
	# send back the manipulated image
	dirName, fileBaseName, fileExtension = fileparts(local_filename)
	new_fn = os.path.join(dirName, fileBaseName + '_ok' + fileExtension)
	bot.sendImage(chat_id, new_fn, "")



if __name__ == "__main__":
	bot_id = '1033098410:AAGhkngtsmD_EqOmCMnkt1LfGXCl4gyZNIw'
	updater = Updater(bot_id)
	updater.setPhotoHandler(imageHandler)
	updater.start()