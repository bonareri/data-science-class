import os

FILE_NAME = "patients.txt"

# ----------------------------
# LOAD DATA FROM FILE
# ----------------------------
def load_data():
    patients = {}

    if not os.path.exists(FILE_NAME):
        open(FILE_NAME, "w").close()
        return patients

    with open(FILE_NAME, "r") as file:
        for line in file:
            line = line.strip()
            if line:
                name, age, doctor, status = line.split(",")
                patients[name] = {
                    "age": int(age),
                    "doctor": None if doctor == "None" else doctor,
                    "status": status
                }

    return patients


# ----------------------------
# SAVE DATA TO FILE
# ----------------------------
def save_data(patients):
    with open(FILE_NAME, "w") as file:
        for name, info in patients.items():
            doctor = info["doctor"] if info["doctor"] else "None"
            line = f"{name},{info['age']},{doctor},{info['status']}\n"
            file.write(line)


# ----------------------------
# ADD PATIENT
# ----------------------------
def add_patient(patients):
    name = input("Enter patient name: ")

    if name in patients:
        print("Patient already exists")
        return

    age = int(input("Enter age: "))

    patients[name] = {
        "age": age,
        "doctor": None,
        "status": "Waiting"
    }

    save_data(patients)
    print("Patient added successfully")


# ----------------------------
# VIEW ALL PATIENTS
# ----------------------------
def view_patients(patients):
    if not patients:
        print("No patients found")
        return

    print("\nPatient Records:")
    for name, info in patients.items():
        print(f"{name} | Age: {info['age']} | Doctor: {info['doctor']} | Status: {info['status']}")


# ----------------------------
# SEARCH PATIENT
# ----------------------------
def search_patient(patients):
    keyword = input("Enter name to search: ").lower()
    found = False

    for name, info in patients.items():
        if keyword in name.lower():
            print(f"{name} | {info}")
            found = True

    if not found:
        print("No matching patient found")


# ----------------------------
# ASSIGN DOCTOR
# ----------------------------
def assign_doctor(patients):
    name = input("Enter patient name: ")

    if name not in patients:
        print("Patient not found")
        return

    if patients[name]["status"] == "Discharged":
        print("Patient already discharged")
        return

    if patients[name]["doctor"] is not None:
        print("Patient already has a doctor")
        return

    doctor = input("Enter doctor name: ")

    patients[name]["doctor"] = doctor
    patients[name]["status"] = "Under Treatment"

    save_data(patients)
    print(f"{doctor} assigned to {name}")


# ----------------------------
# DISCHARGE PATIENT
# ----------------------------
def discharge_patient(patients):
    name = input("Enter patient name: ")

    if name not in patients:
        print("Patient not found")
        return

    if patients[name]["status"] != "Under Treatment":
        print("Patient is not under treatment")
        return

    patients[name]["status"] = "Discharged"
    patients[name]["doctor"] = None

    save_data(patients)
    print(f"{name} has been discharged")


# ----------------------------
# SUMMARY REPORT
# ----------------------------
def summary(patients):
    waiting = 0
    treatment = 0
    discharged = 0

    for info in patients.values():
        if info["status"] == "Waiting":
            waiting += 1
        elif info["status"] == "Under Treatment":
            treatment += 1
        elif info["status"] == "Discharged":
            discharged += 1

    print("\n Summary Report")
    print(f"Waiting: {waiting}")
    print(f"Under Treatment: {treatment}")
    print(f"Discharged: {discharged}")


# ----------------------------
# MAIN PROGRAM LOOP
# ----------------------------
def main():
    patients = load_data()

    while True:
        print("\n===== HOSPITAL SYSTEM =====")
        print("1. Add Patient")
        print("2. View Patients")
        print("3. Search Patient")
        print("4. Assign Doctor")
        print("5. Discharge Patient")
        print("6. Summary Report")
        print("7. Exit")

        choice = input("Choose option: ")

        if choice == "1":
            add_patient(patients)

        elif choice == "2":
            view_patients(patients)

        elif choice == "3":
            search_patient(patients)

        elif choice == "4":
            assign_doctor(patients)

        elif choice == "5":
            discharge_patient(patients)

        elif choice == "6":
            summary(patients)

        elif choice == "7":
            save_data(patients)
            print("Goodbye!")
            break

        else:
            print("Invalid option")


# Run program
main()