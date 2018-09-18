#! /usr/bin/env python3
# -*- coding: utf-8 -*-
import random

# Initialize seed so we always get the same result between two runs.
# Comment this out if you want to change results between two runs.
# More on this here: http://stackoverflow.com/questions/22639587/random-seed-what-does-it-do
random.seed(0)

##################################################
#################### VOTES SETUP #################
##################################################

VOTES = 100000
MEDIAN = VOTES / 2
CANDIDATES = {
    "hermione": "Hermione Granger",
    "balou": "Balou",
    "chuck-norris": "Chuck Norris",
    "elsa": "Elsa",
    "gandalf": "Gandalf",
    "beyonce": "Beyoncé"
}

MENTIONS = [
    "A rejeter",
    "Insuffisant",
    "Passable",
    "Assez Bien",
    "Bien",
    "Très bien",
    "Excellent"
]


def create_votes():
    return [
        {
            "hermione": random.randint(4, 6),
            "balou": random.randint(0, 6),
            "chuck-norris": random.randint(0, 6),
            "elsa": random.randint(0, 6),
            "gandalf": random.randint(0, 6),
            "beyonce": random.randint(0, 6)
        } for _ in range(0, VOTES)
    ]


##################################################
#################### FUNCTIONS ###################
##################################################

def results_hash(votes):
    candidate_vote = {
        candidate: [0] * len(MENTIONS)
        for candidate in CANDIDATES.keys()
    }
    for vote in votes:
        for candidate, mention in vote.items():
            candidate_vote[candidate][mention] += 1

    return candidate_vote
    # return {candidate: [x, x, x, x, x, x], ... }


def majoritary_hash(resultat_vote):
    r = {}

    for candidate, vote_result in resultat_vote.items():

        cumulated_votes = 0
        for mention, vote_count in enumerate(vote_result):
            cumulated_votes += vote_count
            if cumulated_votes >= MEDIAN:
                r[candidate] = {'mention': mention, 'score': cumulated_votes}
                break

    return r


def sort_candidate_by(mentions):
    unsorted = [(candidate, (information['mention'], information['score']))
                for candidate, information in mentions.items()]

    for i in range(0, len(unsorted) - 1):
        j = i
        while unsorted[j + 1][1][0] > unsorted[j][1][0]:
            unsorted[j + 1], unsorted[j] = unsorted[j], unsorted[j + 1]
            j -= 1

    for i in range(1, len(unsorted)):
        for j in range(i):
            if unsorted[j][1][0] == unsorted[i][1][0]:
                if unsorted[j][1][1] < unsorted[i][1][1]:
                    unsorted[j:j] = [unsorted[i]]
                    del unsorted[i + 1]
                    break

    return [{candidate[0]: {'mention': candidate[1][0], 'score': candidate[1][1]}} for candidate in unsorted]


def print_result(sorted_votes):
    for i, dicto in enumerate(sorted_votes):
        name = list(dicto.keys())[0]
        mention = MENTIONS[dicto[name]['mention']]
        score = dicto[name]['score'] * 100 / VOTES
        if i == 0:
            print("Gagnant: {} avec {:.2f}% de mentions {}".format(
                name, score, mention
            ))
            continue
        else:
            print("- {} avec {:.2f}% de mentions {}".format(
                name, score, mention
            ))


##################################################
#################### MAIN FUNCTION ###############
##################################################

def main():
    votes = create_votes()
    resultat_vote = results_hash(votes)
    cumulated_votes = majoritary_hash(resultat_vote)
    sorted_votes = sort_candidate_by(cumulated_votes)
    print(print_result(sorted_votes))


if __name__ == '__main__':
    main()
