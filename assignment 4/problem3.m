raw_im = Tiff('trees.tif','r');
im = raw_im.readRGBAImage();
im = im2double(im(1:200,1:200,:));
imshow(im);
[h, w, ~] = size(im);

K = 6;
mu = zeros([K 3]);
for k = 1:K
    mu_h = randi([1 h]);
    mu_w = randi([1 w]);
    mu(k,:) = im(mu_h, mu_w,:);
end

W = zeros(h, w, K);
it = 0;
while true
    prev_W = W;
    for i = 1:h
        for j = 1:w
            d = Inf;
            for k = 1:K
                if norm(mu(k,:)-squeeze(im(i,j,:))')< d
                    d = norm(mu(k,:)-squeeze(im(i,j,:))');
                    W(i,j,:)=0;
                    W(i,j,k)=1;
                end
            end
        end
    end
    it = it+1;
    if isequal(prev_W, W)
        break
    end
    
    for k = 1:K
        for c = 1:3
            mu(k,c) = (sum(sum(im(:,:,c).*W(:,:,k))))/sum(sum(W(:,:,k)));
        end
    end
end

ind = find(isnan(mu));
mu(ind)=0;


new_im = zeros(h,w,3);
for k=1:K
    for c=1:3
        new_im(:,:,c) = new_im(:,:,c)+mu(k,c)*W(:,:,k);
    end
end

imshow(new_im);

