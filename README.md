# Processing EEG Signal #

In this project, I employed EEGLAB to process EEG signal from a subject in a resting-wakeful state with their eyes opened and closed. 

The objective was to process raw EEG data and confirm the behaviour of the subject. 


# Channel Locations #

![image](https://user-images.githubusercontent.com/33042545/105569138-0c1dfe80-5cf4-11eb-82b2-5a96d1167c27.png)



# Raw EEG Data #

![image](https://user-images.githubusercontent.com/33042545/105569158-3b347000-5cf4-11eb-9f0e-c21b51c01414.png)

  - Removed DC Off-set

    - ![image](https://user-images.githubusercontent.com/33042545/105569184-6b7c0e80-5cf4-11eb-98e8-53579c65daf2.png)


 -  Average Referencing and Import Epochs

    - ![image](https://user-images.githubusercontent.com/33042545/105569211-a0886100-5cf4-11eb-9ebe-bc41389c4eb9.png)


 - Power Spectral Density Plot of unfiltered Data

    - ![image](https://user-images.githubusercontent.com/33042545/105569255-15f43180-5cf5-11eb-968e-ec40bda62f31.png)



# Pre-Processing Results # 

- Remove Drift at Low Frequencies
    - ![image](https://user-images.githubusercontent.com/33042545/105569398-193bed00-5cf6-11eb-9910-7ad6fec937d8.png)

- Remove 60 Hz Line Noise
    - ![image](https://user-images.githubusercontent.com/33042545/105569419-47b9c800-5cf6-11eb-8d71-eb163e24e14b.png)

- Independent Component Analysis 
    - ![image](https://user-images.githubusercontent.com/33042545/105569448-70da5880-5cf6-11eb-9221-30cdf25e6a84.png)
    - ![image](https://user-images.githubusercontent.com/33042545/105569464-99625280-5cf6-11eb-8a32-acbb8791dd4b.png)
    
# Filtered Cleaned Data # 

![image](https://user-images.githubusercontent.com/33042545/105569490-c4e53d00-5cf6-11eb-88ee-d64f128ba500.png)


# Feature Extraction #

- Wavelet Transformation of O1 and Oz Electrodes
  -  For my time-frequency decomposition, I used the default 3 wavelet cycle at the lowest frequency of 6Hz and the wavelet cycle increased linearly for higher          frequencies by a factor of 0.5
    - ![image](https://user-images.githubusercontent.com/33042545/105569520-1ab9e500-5cf7-11eb-9491-d619aab3417b.png)

    - ![image](https://user-images.githubusercontent.com/33042545/105569532-2c02f180-5cf7-11eb-9911-cc6d210c0d74.png)
    
  - Based on the time-trequency decomposition of channel O1, we can notice the decrease in power in the beta bands after the event marker and an increase in power in the gamma band in occipital region. This power transition corresponds to transitioning from Resting Eyes Closed to Resting Eyes Open[1]. At time=610ms you can notice the significant decrease in beta band and an increase in gamma band in the occipital region. Therefore, knowing that the dataset used was recorded from an individual in a resting wakeful state with their eyes open and close, the time-frequency decomposition of their cleaned brain data confirms this, based on the assumption that the subject was in a complete dark room. 
  
  - Channel Oz is beside channel O1 and we expect the two channels to pick up the same information. Based on the assumption that the EEG recordings were made in a complete dark room, note the high-power activity in beta band at 400ms and then notice the significant increase in power in the gamma band at 420ms and decrease in power in the Beta band. This power transition corresponds to transitioning from Resting Eyes Closed to Resting Eyes Open [1]. 
  
# Coherency and Synchrony #

  - ![image](https://user-images.githubusercontent.com/33042545/105569557-5c4a9000-5cf7-11eb-893f-68d8eef2eed0.png)
  
  - The channel cross-coherence plot above, note that channels O1 and Oz have good phase synchronization around the alpha and beta bands. By showing a strong coherency between the channels that are within close proximity, we can conclude functional connectivity between the two channels Oz and O1. They’re both capturing the same brain activity in response to the event of eyes opening and closing. 

# Power Spectral Density of Cleaned Data 

![image](https://user-images.githubusercontent.com/33042545/105569603-b5b2bf00-5cf7-11eb-823b-6fb0dbaf7114.png)

# Result # 

Based on the PSD plot of cleaned data, after filtering the subject’s EEG data and using ICA to remove EOG and channel noise artifacts, the power spectral density revealed that the neural activity appears to be primarily in the occipital region as shown in the topographic plot shown in PSD plot of cleaned data above. Also, note that the power spectral density has the largest peak around the alpha band, which is predominantly found in the occipital region of the brain. The existence of strong alpha waves in the dataset correspond to the subject being in a very relaxed state. 
