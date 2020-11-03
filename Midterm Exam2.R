# Data Processing Leanuage 
# Midterm Exam (1)

# 3������ TV ��û��
install.packages("rvest")
install.packages("lubridate")
install.packages("scales")

# ���̺귯�� �ҷ�����
library(rvest) # ��ũ���� ���� ���̺귯��
library(lubridate) # ��¥ ���� ���̺귯��
library(ggplot2) # plot ���� ���̺귯��

url.page <- "https://search.naver.com/search.naver?where=nexearch&sm=tab_etc&query=7��%2031�ϵ�󸶸���û��"
query = "https://search.naver.com/search.naver?where=nexearch&sm=tab_etc&query="
monthUrl = "��%20"
dayUrl = "�ϵ�󸶽�û��"

week = 13 # �� ��ġ �ҷ�����..
startDate = date("2020-07-31") # ���� ��¥ 

list = list()
for(i in c(1:week)) {
  month <- month(startDate)
  day <- day(startDate)
  url <- paste(query, month, monthUrl, day, dayUrl,sep="") # url ����
  html <- read_html(url)
  # ��Ʈ�� ��� ������ ����
  title <- html_nodes(html, ".tb_list tr td p") %>% html_text()
  title <- title[seq(2,length(title), 4)] # ����� ��۱��� �ҷ��� Ȧ�� �ε����� �ֱ�(����)
  rating <- html_nodes(html, '.rate') %>% html_text()
  rating <- substring(rating, 1, regexpr("%", rating)-1) # %����
  list[[i]] = rbind(title,rating) # list�� �� �߰�
  startDate <- startDate + 7
}

# ������������ ����
titles = NULL
ratings = NULL
weeks = NULL

for(i in c(1:week)) {
  titles = c(titles, list[[i]][1,])
  ratings = c(ratings, list[[i]][2,])
  weeks = c(weeks, rep(i, times = length(list[[i]][1, ])))
}
df = data.frame(titles, weeks, ratings = as.numeric(ratings))

# ��û�� 3%�̸� ����
min_rate = 3
delete_row = NULL
index = 1
for(i in df[, 3]) {
  if (i<min_rate) {
    delete_row = c(delete_row, index)
  }
  index = index + 1
}
delete_row
df <- df[-delete_row,]

# ��Ʈ �׸���
print(
  ggplot(df, aes(weeks, ratings))
  # + theme(legend.position = "none")
  + geom_line(aes(linetype = titles, color = titles), size = 2)
  # + scale_color_brewer(palette = 1)
  + scale_x_continuous(limits = c(1, week), breaks = seq(1, week, 1))
  + scale_y_continuous(limits = c(0, 30), breaks = seq(0, 30, 3))
  )

# ���̹����� �Ϻ� ��� ����� ��û���� �ҷ��� �ݿ��� ��󸶸� ȸ�� ��û��(�ֺ� ��û��)��
# 3����ġ�� �� �� �ֵ����Ͽ� ��� �濵�ϰ� ������, �׿� ���� �ٸ� ���� ����� ��û����
# ������ �ִ��� �˾ƺ��� ���� ��Ʈ�� �׷���.
# ��������� �⸷�� �����̳� ������ ��� �濵�ϰ� �������� ����, �ٸ� ����� ��û����
# ������ ��ġ�� ���� �� �� �ִ�.