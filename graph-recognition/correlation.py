#!/usr/bin/env python3

import numpy as np
import pyautogui
import PIL
import webbrowser
import time

## Open a Chrome tab of the website

url = 'https://www.guessthecorrelation.com/'
chrome_path = 'open -a /Applications/Google\ Chrome.app %s'
webbrowser.get(chrome_path).open(url)

## Add a 2 second delay

time.sleep(2)

## Click on start game

pyautogui.click()

pyautogui.moveTo(720, 300) 

pyautogui.click(clicks=2, interval=0.25)

time.sleep(2)

## Start the while true loop

while True:

	time.sleep(0.2)

	## Take the screenshot of the plot

	im = pyautogui.screenshot(region=(329, 232, 661-328, 530-205))

	## Convert to RBG format from RGBA

	im2 = im.convert('RGB')

	## Get data into numpy array and average over the colors to make greyscale

	data = np.array(im2)
	mean = np.mean(data, axis=2)

	## Get the empty arrays to get appended

	x = []
	y = []

	## Loop through the image and find pixel coordinates less than a threshold

	for j in range(len(mean)):
		for i in range(len(mean[j])):
			if mean[j][i] < 30:
				x.append(i)
				y.append(j)

	## Get the correlation coefficient

	cor_coef = np.abs(np.corrcoef(x,y)[0,1])

	nums = [d for d in str(cor_coef)]

	pyautogui.press(nums[2])
	pyautogui.press(nums[3])

	pyautogui.press('enter')
	pyautogui.press('enter')