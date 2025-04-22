# Berlin Entdecken

## Table of Contents
1. [Overview](https://hackmd.io/2V4h4Z_NTCOtHFWE5bcU_A#Description)
2. [Product Spec](https://hackmd.io/2V4h4Z_NTCOtHFWE5bcU_A#Product-Spec)
3. [Wireframes](https://hackmd.io/2V4h4Z_NTCOtHFWE5bcU_A#Wireframes)
4. [Schema](https://hackmd.io/2V4h4Z_NTCOtHFWE5bcU_A#Schema)

## Overview :linked_paperclips: 

### Description
Berlin Entdecken is an app that combines both Travel and Education categories, helping tourists learn common German grammar rules and phrases needed in and around famous attractions in Berlin-Mitte. The app allows users to discover landmarks in Berlin while simultaneously learning practical German language skills, focusing on Nominativ, Akkusativ, and Dativ cases through interactive exercises tied to specific locations.

### App Evaluation :star: 
* **Category:** Travel & Education
* **Mobile:** Location-based learning experiences tied to Berlin landmarks; map integration for navigation; camera integration for scanning information plaques; push notifications for nearby attractions
* **Story:** Berlin attracts millions of tourists who often struggle with language barriers. This app provides contextual language learning tied to specific locations rather than generic phrases, making the tourist experience more immersive and educational.
* **Market:** Berlin attracts around 14 million tourists annually who struggle with language barriers. The app targets both language learners and travelers - a dual market. The niche value is in providing contextual language learning tied to specific locations, rather than generic phrases.
* **Habit:** Users would open the app multiple times daily during their Berlin trip - whenever they encounter a new landmark or need language assistance. Location-based triggers create natural usage patterns throughout a tourist's journey.
* **Scope:** The core functionality is clearly defined: location-based language lessons tied to Berlin attractions. A stripped-down MVP could focus on just Brandenburg Gate and Alexanderplatz areas with basic phrases, which would still demonstrate the concept effectively.

## Product Spec :iphone: 

### 1. User Stories (Required and Optional)

#### Required Must-have Stories
* User can view a map of Berlin highlighting major landmarks
* User can select a landmark to learn basic information about it in German and English
* User can practice German grammar (Nominativ, Akkusativ, Dativ) through exercises related to specific landmarks
* User can learn "Word of the Day" with contextual usage examples
* User can track their progress through different grammar exercises

#### Optional Nice-to-have Stories
* User can save favorite words/phrases to review later
* User can take a quiz based on previously learned content
* User can see pronunciation guides with audio for German phrases
* User can set daily learning goals and get reminders
* User can earn badges for completing exercises at different landmarks

### 2. Screen Archetypes

* **Map Screen (Main Page)**
  * User can view a map of Berlin highlighting major landmarks
  * User can select a landmark to learn more

* **Landmark Info Screen**
  * User can see information about the landmark in German and English
  * User can learn historical and cultural context

* **Practice Screen**
  * User can practice Nominativ, Akkusativ, and Dativ cases
  * User can complete grammar exercises related to the landmark

* **Daily Challenge Screen**
  * User can practice daily exercises to reinforce learning
  * User can learn the "Word of the Day"

* **Saved Words/Profile Screen**
  * User can review saved words and phrases
  * User can track progress and achievements

### 3. Navigation :airplane_departure: 

#### Tab Navigation (Tab to Screen)
* Map/Home
* Practice
* Daily Challenge
* Saved Words/Profile

#### Flow Navigation (Screen to Screen)
* **Map Screen**
  * => Info Page (when selecting a landmark)
  
* **Info Page**
  * => Back to Map
  * => Practice Page (for related grammar exercises)
  
* **Practice Page**
  * => Back to Info Page
  * => Results/Completion Page

* **Daily Challenge**
  * => Practice specific grammar type
  * => Word of the Day details

* **Saved Words/Profile**
  * => Word details
  * => Practice related words

## Wireframes :frame_with_picture: 
<img width="103" alt="Screenshot 2025-04-21 at 11 45 10 PM" src="https://github.com/user-attachments/assets/eff6d4bb-7fbc-4df9-bc07-5e08ac4a1f42" />
<img width="397" alt="Screenshot 2025-04-21 at 11 45 05 PM" src="https://github.com/user-attachments/assets/47aa1d08-7739-4c97-8883-ae6e6a0af2c5" />
<img width="396" alt="Screenshot 2025-04-21 at 11 44 57 PM" src="https://github.com/user-attachments/assets/aa4559c8-aa82-49e1-8f9d-74588d683642" />


### Digital Wireframes & Mockups
The Figma design shows a comprehensive set of screens including Main Page with map, Info Pages for landmarks, Practice Pages for grammar, and Saved Words/Profile sections.

### [Interactive Prototype](https://www.figma.com/proto/z7uRpMMaKIRRTgl9Joaj4w/Berlin-Entdecken-App-?node-id=0-1&t=DgYoT8VIJAq1Cy9d-1)

<img width="397" alt="Screenshot 2025-04-21 at 11 51 45 PM" src="https://github.com/user-attachments/assets/007424f0-fd1f-4c8d-a42b-1db9a26d3cdc" />

Click [here](https://www.figma.com/proto/z7uRpMMaKIRRTgl9Joaj4w/Berlin-Entdecken-App-?node-id=0-1&t=DgYoT8VIJAq1Cy9d-1) to interact with the prototype.
      
