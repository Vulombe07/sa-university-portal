def check_eligibility(aps,marks,requirements):
    if aps < requirements["minimum_aps"]: 
        return False 

    student_subjects = [mark["subject"] for mark in marks]

    ##I assume they have all subjects until proven otherwise
    for requirement in requirements["subjects"]:
        if requirement["subject"] not in student_subjects:
            return False
    

    for requirement in requirements["subjects"]:
        for subject in marks:
            if subject["subject"]==requirement["subject"]:
                if subject["percentage"] < requirement["minimum_percentage"]:
                    return False
    return True
