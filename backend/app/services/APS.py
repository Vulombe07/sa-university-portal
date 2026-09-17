def calculate_up_aps(marks):
    aps = 0
    for mark in marks:
        if mark["subject"] == "Life Orientation":
            continue
        if mark["percentage"]>=80:
            aps = aps + 7
        elif mark["percentage"]>=70 and mark["percentage"]<=79:
            aps = aps + 6
        elif mark["percentage"]>=60 and mark["percentage"]<=69:
            aps = aps + 5
        elif mark["percentage"]>=50 and mark["percentage"]<=59:
            aps = aps + 4
        elif mark["percentage"]>=40 and mark["percentage"]<=49:
            aps = aps + 3
        elif mark["percentage"]>=30 and mark["percentage"]<=39:
            aps = aps + 2
        elif mark["percentage"]>=0 and mark["percentage"]<=29:
            aps = aps + 1
    return aps

def calculate_wits_aps(marks):
    aps = 0
    for mark in marks:
        if mark["subject"] == "Life Orientation":
            if mark["percentage"] >= 90 and mark["percentage"]<=100:
                aps = aps + 4
            elif mark["percentage"]>=80 and mark["percentage"]<=89:
                aps = aps + 3
            elif mark["percentage"]>=70 and mark["percentage"]<=79:
                aps = aps + 2
            elif mark["percentage"]>=60 and mark["percentage"]<=69:
                aps = aps + 1

        elif mark["subject"] == "English Home Language" or mark["subject"] == "English First Additional Language" or mark["subject"] == "Mathematics":
            if mark["percentage"]>=90 and mark["percentage"]<=100:
                aps = aps + 10
            elif mark["percentage"]>=80 and mark["percentage"]<=89:
                aps = aps + 9
            elif mark["percentage"]>=70 and mark["percentage"]<=79:
                aps = aps + 8
            elif mark["percentage"]>=60 and mark["percentage"]<=69:
                aps = aps + 7
            elif mark["percentage"]>=50 and mark["percentage"]<=59:
                aps = aps + 4
            elif mark["percentage"]>=40 and mark["percentage"]<=49:
                aps = aps + 3

        else:
            if mark["percentage"]>=90 and mark["percentage"]<=100:
                aps = aps + 8
            elif mark["percentage"]>=80 and mark["percentage"]<=89:
                aps = aps + 7
            elif mark["percentage"]>=70 and mark["percentage"]<=79:
                aps = aps + 6
            elif mark["percentage"]>=60 and mark["percentage"]<=69:
                aps = aps + 5
            elif mark["percentage"]>= 50 and mark["percentage"]<=59:
                aps = aps + 4
            elif mark["percentage"]>=40 and mark["percentage"]<=49:
                aps = aps + 3
    return aps

def calculate_uct_aps(marks):
    aps = 0
    for mark in marks:
        if mark["subject"] == "Life Orientation":
            continue
        else:
            if mark["percentage"]<40:
                continue
            else:
                aps = aps + mark["percentage"]
    return aps ##will add fps calculations later

def calculate_stellenbosch_nsc_average(marks):
    total = 0
    for mark in marks:
        if mark["subject"] == "Life Orientation":
            continue
        else:
             total = total + mark["percentage"]
    return total/(len(marks)-1)

def calculate_uwc_aps(marks):
    aps = 0
    for mark in marks:
        if mark["subject"] == "English Home Language" or mark["subject"] == "English First Additional Language" or mark["subject"] == "Mathematics":
            if mark["percentage"]>=90 and mark["percentage"]<=100:
                aps  = aps + 15
            elif mark["percentage"]>=80 and mark["percentage"]<=89:
                aps = aps + 13
            elif mark["percentage"]>=70 and mark["percentage"]<=79:
                aps = aps + 11
            elif mark["percentage"]>=60 and mark["percentage"]<=69:
                aps = aps + 9
            elif mark["percentage"]>=50 and mark["percentage"]<=59:
                aps = aps + 7
            elif mark["percentage"]>= 40 and mark["percentage"]<=49:
                aps = aps + 5
            elif mark["percentage"]>=30 and mark["percentage"]<=39:
                aps = aps + 3
            elif mark["percentage"]>=20 and mark["percentage"]<=29:
                aps = aps + 1

        elif mark["subject"] == "Life Orientation":
            if mark["percentage"]>=90 and mark["percentage"]<=100:
                aps  = aps + 3
            elif mark["percentage"]>=80 and mark["percentage"]<=89:
                aps = aps + 3
            elif mark["percentage"]>=70 and mark["percentage"]<=79:
                aps = aps + 2
            elif mark["percentage"]>=60 and mark["percentage"]<=69:
                aps = aps + 2
            elif mark["percentage"]>=50 and mark["percentage"]<=59:
                aps = aps + 2
            elif mark["percentage"]>= 40 and mark["percentage"]<=49:
                aps = aps + 1
            elif mark["percentage"]>=30 and mark["percentage"]<=39:
                aps = aps + 1
            elif mark["percentage"]>=20 and mark["percentage"]<=29:
                aps = aps + 1

        else:
            if mark["percentage"]>=90 and mark["percentage"]<=100:
                aps  = aps + 8
            elif mark["percentage"]>=80 and mark["percentage"]<=89:
                aps = aps + 7
            elif mark["percentage"]>=70 and mark["percentage"]<=79:
                aps = aps + 6
            elif mark["percentage"]>=60 and mark["percentage"]<=69:
                aps = aps + 5
            elif mark["percentage"]>=50 and mark["percentage"]<=59:
                aps = aps + 4
            elif mark["percentage"]>= 40 and mark["percentage"]<=49:
                aps = aps + 3
            elif mark["percentage"]>=30 and mark["percentage"]<=39:
                aps = aps + 2
            elif mark["percentage"]>=20 and mark["percentage"]<=29:
                aps = aps + 1
    return aps