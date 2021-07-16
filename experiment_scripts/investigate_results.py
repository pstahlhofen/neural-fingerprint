import json
import os
import numpy as np
import matplotlib as mpl
mpl.use('tkagg')
import matplotlib.pyplot as plt

res_and_log_files = os.listdir('results')
no_log = lambda file_name: '_log.txt' not in file_name
res_files = filter(no_log, res_and_log_files)
res_files = ['results/{}'.format(res_file) for res_file in res_files]
training_curves = []
for res_file in res_files:
	with open(res_file, 'r') as fp:
		res = json.load(fp)
		training_curve = np.array(res[1]['training_curve'])
		training_curves.append((res_file, training_curve))

def monotoniously_decreasing_test_error():
	properly_learned = []
	for res_file, training_curve in training_curves:
		test_errors = training_curve[:, 2]
		if all(test_errors==sorted(test_errors, reverse=True)):
			properly_learned.append(res_file)
	return properly_learned

#print(monotoniously_decreasing_test_error())
last_test_error = lambda curve: curve[1][-1,2]
test_errors = [last_test_error(curve) for curve in training_curves]
not_nan = lambda x : not np.isnan(x)
test_errors = list(filter(not_nan, test_errors))
plt.hist(test_errors, bins=20)
plt.show()
#training_curves = sorted(training_curves, key=last_test_error)
#model_colors = dict(mean = 'k',
#                    morgan_plus_linear = 'g',
#                    morgan_plus_net = 'y',
#                    conv_plus_linear = 'b',
#                    conv_plus_net = 'r')
#string_list = []
#for curve in training_curves:
#	res_file = curve[0][8:]
#	for model, color in model_colors.items():
#		if model in res_file:
#			string_list.append(color)
#			break
#	print('{}: {}'.format(curve[0][8:], round(last_test_error(curve), ndigits=3)))
#print ''.join(string_list)
