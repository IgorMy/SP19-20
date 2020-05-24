function coef_corr = funcion_calula_coeficiente_correlacion_lineal_2_variables(mCov)

    sigma1 = sqrt(mCov(1,1));
    sigma2 = sqrt(mCov(2,2));
    
    coef_corr = mCov(1,2)/(sigma1*sigma2);

end