import pandas as pd
import visualize as vis
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix
from sklearn.metrics import f1_score
from sklearn.metrics import accuracy_score
from sklearn.metrics import precision_score
from sklearn.metrics import recall_score
from sklearn.ensemble import RandomForestClassifier
from sklearn import preprocessing
import numpy as np
 
# CSVファイルを読み込む
df = pd.read_csv('data4.csv', delimiter=",")
 
# 説明変数列と目的変数列に分割
label = df['flag']
data  = df.drop('flag', axis=1)
count = df['flag'].value_counts()
 
# 学習用データとテストデータにわける
train_data, test_data, train_label, test_label = train_test_split(data, label, test_size=0.5)
 
# 学習する
clf = RandomForestClassifier(n_estimators=500)
clf.fit(train_data, train_label)
 
# 評価する
predict = clf.predict(test_data)
rate_sum = 0
 
#for i in range(len(test_label)):
 # t = int(test_label.iloc[i])
 # p = int(predict[i])
 # rate_sum += int(min(t, p) / max(t, p) * 100)
#print(rate_sum / len(test_label))

print('{:.4f}'.format(clf.score(train_data, train_label)))
print('{:.4f}'.format(clf.score(test_data, test_label)))

confusion =  confusion_matrix(test_label, clf.predict(test_data))
confusion0 = ' '.join(map(str, confusion[0]))
confusion1 = ' '.join(map(str, confusion[1]))
confusion2 = ' '.join(map(str, confusion[2]))
print('%s %s %s ' % (confusion0, confusion1, confusion2))
print('{:.4f}'.format(accuracy_score(test_label, clf.predict(test_data))))

precision = ' '.join(map(str,(precision_score(test_label, clf.predict(test_data), average=None))))
recall_score = ' '.join(map(str,(recall_score(test_label, clf.predict(test_data), average=None))))
f1_score = ' '.join(map(str,(f1_score(test_label, clf.predict(test_data), average=None))))
print('%s ' % (precision))
print('%s ' % (recall_score))
print('%s ' % (f1_score))

fti = clf.feature_importances_
for i in range(7):
    print(fti[i])

