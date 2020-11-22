# 11-2����

# ǥ������, ���� 
sample(c("�ո�", "�޸�"), 20, replace=T)
runif(10, min = 0, max = 10) # �ּҰ� 0���� �ִ밪 10���� �յ��ϰ� ����

iteration = 5000
plot(0, 0, xlab="������ ���� Ƚ��", ylab="�ո��� ������ ����", 
     xlim=c(0, iteration), ylim=c(0,1))
abline(a=0.5, b=0, col="red")

sum = 0
for(x in 1:iteration) {
  
  # ����������
  coin = sample(c("�ո�", "�޸�"), 1, replace=T)
  
  if(coin == "�ո�") {
    sum = sum + 1
  }
  
  prob = sum / x
  points(x, prob)
}

x = sample(c(0,1), iteration, replace=T)
result = sum(x) / iteration
result
round(result * 100, 1)