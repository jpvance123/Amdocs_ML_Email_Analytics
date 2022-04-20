import os, time
import mailbox
from email.parser import BytesParser
from email.policy import default

INBOX = '/home/jpvance123/Desktop/Email_Analytics/MailDir_to_MBOX/enron/enron.badeer-r._sent_mail'

print('Messages in ', INBOX)

mymail = mailbox.mbox(INBOX, factory=BytesParser(policy=default).parse)

for _, message in enumerate(mymail):
    date = message['date']
    to = message['to']
    sender = message['from']
    subject = message['subject']
    messageID = message['Message-ID']
    received = message['received']
    deliveredTo = message['Delivered-To']
    if(messageID == None): continue

    print("Date        :", date)
    print("From        :", sender)
    print("To:         :", to)
    print('Delivered-To:', deliveredTo)
    print("Subject     :", subject)
    print("Message-ID  :", messageID)
#     print('Received    :', received)

    print("**************************************")