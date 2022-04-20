# Amdocs-Email-Analytics

Step 1: Obtain MBOX data source, for the purpose of this project I selected Enron Email Corpus (Found here https://www.cs.cmu.edu/~enron/) because of it's fraduealent email type and high volume. 
	Once downloaded, run the following command in the same directory as the zip to unpack the dataset</br>
	`$ tar xvfz enron_mail_20150507.tgz`

Step 2: Convert Mail Dir format of Emails from Enron into MBOX format.</br>	
	As the scope of this project was to work with email datasets I've used a script I found online to convert the dataset into the desired format of MBOX. You can find the original version here (https://github.com/lintool/Enron2mbox), which you may have to edit yourself in order to get your desired results as I had too. Running the script as followed</br>
	`$ python3 conversion_script.py`</br>
	
	The github previously linked also has scripts to check the integrity of the conversion which I highly recommend. 
	

Step 3: Now that the emails have been converted to MBOX we can begin exploring the dataset. 

Step 4: Feel free to use the functions created in this repository as a starting point for exploring email analytics. </br>
It is your turn to take the torch and venture deeper into the void. 

# Resources Used
**For mbox parsing:**

https://github.com/mikhailklassen/Mining-the-Social-Web-3rd-Edition/blob/master/notebooks/Chapter%207%20-%20Mining%20Mailboxes.ipynb

https://www.oreilly.com/library/view/mining-the-social/9781449368180/ch06.html

**For ML:**
http://www.diva-portal.org/smash/get/diva2:1189491/FULLTEXT01.pdf?fbclid=IwAR0_7buh3AaIcTxFwFDq5JCDwAyp1CysbhCIwdNGYHqyk85iVxykeLunOnM
