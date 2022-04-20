import pandas as pd # pip install pandas
import mailbox
from prettytable import PrettyTable
import os
from re import search
import numpy as np

def mailboxParser(mbox_file_list):
        #employee_to_search = self.employee_name
        MBOX = mbox_file_list
        email_df = pd.DataFrame()
        for path in MBOX:
            mbox = mailbox.mbox(path[0])
            mbox_dict = {}
            for i, msg in enumerate(mbox):
                mbox_dict[i] = {}
                for header in msg.keys():
                    mbox_dict[i][header] = msg[header]
                    mbox_dict[i]['Body'] = msg.get_payload().replace('\n', ' ').replace('\t', ' ').replace('\r', ' ').strip()
            email_df = pd.concat([email_df, pd.DataFrame.from_dict(mbox_dict, orient='index')])

        # Remove non-essential columns
        email_df.index = email_df['Date'].apply(pd.to_datetime)
        cols_to_keep = ['From', 'To', 'Cc', 'Bcc', 'Subject', 'Body']
        email_df = email_df[cols_to_keep]

        # Make the dataframe index a datetime index
        email_df.index = pd.to_datetime(email_df.index, utc=True)

        return email_df


def get_file_names_with_strings(employee_list):
        rootDir = "/home/jpvance123/Desktop/Email_Analytics/MailDir_to_MBOX/enron"
        new_list = []
        full_list = os.listdir(rootDir)
        final_list = [nm for ps in employee_list for nm in full_list if ps in nm]
        for path in final_list:
            print(path)
        pathinput = input("**Enter substring of path to search that mailbox's** Which Inbox would you like to use?:\n")
        for path in final_list:
            if search(pathinput, path):
                temp_path = os.path.join(rootDir, path)
                new_list.append([temp_path])
            else:
                continue
        return new_list    

def get_mbox_from_user():
        rootDir = "/home/jpvance123/Desktop/Email_Analytics/MailDir_to_MBOX/enron"
        input_string = input("Enter Employees Names seperated by space: ")
        employee_list = input_string.split(" ")
        employee_file_list = get_file_names_with_strings(employee_list)
        df = mailboxParser(employee_file_list)
        return df

    
def top_10_send_recv(email_df):
        senders = email_df['From'].unique()
        senders = set(senders)
        top_senders = email_df.groupby('From')
        top_senders = top_senders.count()['To']
        # Get the ordered indices of the top senders and receivers in descending order
        top_snd_ord = np.argsort(top_senders)[::-10]
        top_senders = top_senders[top_snd_ord]
        top10_senders = top_senders[:10]

        ## Top 10 Recievers
        receivers = email_df['To'].unique()
        cc_receivers = email_df['Cc'].unique()
        bcc_receivers = email_df['Bcc'].unique()
        receivers = set(receivers)
        cc_receivers = set(cc_receivers)
        bcc_receivers = set(bcc_receivers)
        top_receivers = email_df.groupby('To')
        top_receivers = top_receivers.count()['From']
        top_rcv_ord = np.argsort(top_receivers)[::-1]
        top_receivers = top_receivers[top_rcv_ord]
        top10_recievers = top_receivers[:10]

        
        return top10_senders, top10_recievers, email_df

def pretty_analytics(email_df):
    pt = PrettyTable(field_names=['Rank', 'Sender', 'Messages Sent'])
    pt.title = 'Top 10 Senders'
    pt.align['Messages Sent'] = 'c'
    pt.hrules = 1
    [ pt.add_row([i+1, email, vol]) for i, email, vol in zip(range(10), email_df[0].index.values, email_df[0].values)]
    pt1 = PrettyTable(field_names=['Rank', 'Receiver', 'Messages Received'])
    pt1.title = 'Top 10 Receivers'
    pt1.align['Messages Received'] = 'c'
    pt1.hrules = 1
    [ pt1.add_row([i+1, email[:20], vol]) for i, email, vol in zip(range(10), email_df[1].index.values, email_df[1].values)]

    multiple_df = pd.DataFrame(email_df[2])
    start_date = '2000-1-1'
    stop_date = '2003-1-1'
    datemask = (multiple_df.index > start_date) & (multiple_df.index <= stop_date)
    vol_by_month = multiple_df.loc[datemask].resample('1M').count()['To']
    pt2 = PrettyTable(field_names=['Year', 'Month', 'Num Msgs'])
    pt2.title = 'Volume of emails per month'
    pt2.align['Num Msgs'], pt2.align['Month'] = 'r', 'r'
    [ pt2.add_row([ind.year, ind.month, vol])
    for ind, vol in zip(vol_by_month.index, vol_by_month)]

    return pt, pt1, pt2