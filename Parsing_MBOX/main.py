import pandas as pd # pip install pandas
import mailbox
from prettytable import PrettyTable
import os
from re import search
import numpy as np
from basic_analytics import *
from advanced_analytics import *

"""
    Main Program Runs -> Asks user for MBOX to use -> Begins Analytics -> returns
    Top Senders, Recievers, Volume broken down by Month for a given time period

    Then returns WordCloud for given email dataset being used, clustering Graph, top 10 word features from clustering

    Default time period used: '2000-1-1' - '2003-1-1' -> line 97/98 basic_analytics
"""


if __name__ == "__main__":
    obtain_email_data = get_mbox_from_user()
    analytics_list = top_10_send_recv(obtain_email_data)
    print(pretty_analytics(analytics_list))
    word_cloud(obtain_email_data)
    word_cluster(obtain_email_data)
    word_cosine(obtain_email_data)


