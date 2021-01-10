function X_f = FT_Filter_mulch2(X,thres,type)
% function X_f = FT_Filter(X,thres,type)
% Filtering in Fourier Space (DC is removing)
% Without forcing fft on the longest dimension;



if(nargin<3)
    if ( length(thres) == 1 )
        type = 'low';
    else
        if ( length(thres) == 2 )
            type = 'bandpass';
        else
            tyep = '';
        end
    end
end

if(~strcmp(type,'low') && ~strcmp(type,'high') && ~strcmp(type,'bandpass') && ~strcmp(type,'stop'))
    error('The type of the filter is not correct!');
end
if( (strcmp(type,'low') || strcmp(type,'high')) && length(thres)==2 )
    error('The dimension of threshold is not right');
end
if( (strcmp(type,'bandpass') || strcmp(type,'stop')) && length(thres)==1 )
    error('The dimension of threshold is not right');
end


% if size(X,1)<size(X,2); X = X'; end
nfft = size(X,1);
temp = fft(X);
tmp = temp(1,:); %save the mean, and put it back later

if (strcmp(type,'low'))
    temp(ceil(thres*nfft/2):nfft+2-ceil(thres*nfft/2),:) = 0;
end
if (strcmp(type,'high'))
    temp(2:ceil(thres*nfft/2),:) = 0;
    temp(nfft+2-ceil(thres*nfft/2):end,:) = 0;
end
if (strcmp(type,'bandpass'))
    temp(ceil(thres(2)*nfft/2):nfft+2-ceil(thres(2)*nfft/2),:) = 0;
    temp(2:ceil(thres(1)*nfft/2),:) = 0;
    temp(nfft+2-ceil(thres(1)*nfft/2):end,:) = 0;
end
if (strcmp(type,'stop'))
    temp(ceil(thres(1)*nfft/2):ceil(thres(2)*nfft/2),:) = 0;
    temp(nfft+2-ceil(thres(2)*nfft/2):nfft+2-ceil(thres(1)*nfft/2),:) = 0;
end

temp(1,:) = tmp;
X_f = ifft(temp);
