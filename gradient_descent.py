class LRModel:
    # 초기화작업
    def __init__(self):
        self.w = 1.0 # 가중치 초기화
        self.b = 1.0 # 절편 초기화
    
    # 정방향 계산
    def forpass(self,x):
        y_hat = x * self.w + self.b # 직선방정식을 계산
        return y_hat
    
    # 역방향 계산 (오차율이 들어감)
    def backprop(self,x,err):
        w_grad = x * err # 가중치에 대한 그래디언트
        b_grad = 1 * err # 절편에 대한 그래디언트를 계산
        return w_grad, b_grad
    
    # 훈련
    def fit(self,x,y,epoch): # w와 b는 처음에만 1로 초기화되고 epoch의 크기에 따라 계속 바뀐다.
        for _ in range(epoch):
            for x_i, y_i in zip(x,y):
                y_hat = self.forpass(x_i)
                err = y_i - y_hat
                w_grad, b_grad = self.backprop(x_i,err)
                self.w += w_grad
                self.b += b_grad
        return self.w, self.b