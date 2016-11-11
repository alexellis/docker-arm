#!/usr/bin/env python

import sys
import time

from envirophat import light, weather, motion, analog


def write():
	try:
		p = round(weather.pressure(),2)
		c = light.light()
		print('{"light": '+str(c)+', "pressure": '+str(p)+' }')
	except KeyboardInterrupt:
		pass
write()

