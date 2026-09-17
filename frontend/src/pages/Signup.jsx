import { useState } from "react";

function Signup({ setPage }) {
  const [formData, setFormData] = useState({
    name: "",
    middleName: "",
    surname: "",
    idType: "",
    idNumber: "",
    birthday: "",
    school: "",
    province: "",
    phone: "",
    email: "",
    password: "",
    confirmPassword: "",
  });

  const [subjects, setSubjects] = useState([
    { subject: "", mark: "" },
  ]);

  const subjectOptions = [
    "Mathematics",
    "Mathematical Literacy",
    "Physical Sciences",
    "Life Sciences",
    "Accounting",
    "Business Studies",
    "Economics",
    "Geography",
    "History",
    "Computer Applications Technology",
    "Information Technology",
    "English",
    "Afrikaans",
    "IsiZulu",
    "Sepedi",
    "Sesotho",
    "Setswana",
    "Life Orientation",
  ];

  const provinces = [
    "Eastern Cape",
    "Free State",
    "Gauteng",
    "KwaZulu-Natal",
    "Limpopo",
    "Mpumalanga",
    "Northern Cape",
    "North West",
    "Western Cape",
  ];

  const handleChange = (e) => {
    const { name, value } = e.target;

    setFormData({
      ...formData,
      [name]: value,
    });
  };

  const handleSubjectChange = (index, field, value) => {
    const updatedSubjects = [...subjects];

    updatedSubjects[index][field] = value;

    setSubjects(updatedSubjects);
  };

  const addSubject = () => {
    setSubjects([
      ...subjects,
      { subject: "", mark: "" },
    ]);
  };

  const removeSubject = (index) => {
    if (subjects.length === 1) {
      return;
    }

    const updatedSubjects = subjects.filter(
      (_, subjectIndex) => subjectIndex !== index
    );

    setSubjects(updatedSubjects);
  };

  const handleSubmit = (e) => {
    e.preventDefault();

    if (formData.password !== formData.confirmPassword) {
      alert("Passwords do not match.");
      return;
    }

    for (const subject of subjects) {
      if (!subject.subject || subject.mark === "") {
        alert("Please complete all subject fields.");
        return;
      }

      if (subject.mark < 0 || subject.mark > 100) {
        alert("Marks must be between 0 and 100.");
        return;
      }
    }

    console.log("Signup data:", {
      ...formData,
      subjects,
    });

    alert("Account created successfully!");

    setPage("login");
  };

  return (
    <div className="signup-page">
      <div className="signup-container">

        <div className="signup-header">
          <h1>Create Your Account</h1>
          <p>
            Enter your details to create your UniApply student account.
          </p>
        </div>

        <form onSubmit={handleSubmit}>

          {/* PERSONAL INFORMATION */}
          <section className="form-section">
            <h2>Personal Information</h2>

            <div className="form-grid">

              <div className="form-group">
                <label>Name</label>
                <input
                  type="text"
                  name="name"
                  value={formData.name}
                  onChange={handleChange}
                  placeholder="Enter your name"
                  required
                />
              </div>

              <div className="form-group">
                <label>Middle Name</label>
                <input
                  type="text"
                  name="middleName"
                  value={formData.middleName}
                  onChange={handleChange}
                  placeholder="Enter your middle name"
                />
              </div>

              <div className="form-group">
                <label>Surname</label>
                <input
                  type="text"
                  name="surname"
                  value={formData.surname}
                  onChange={handleChange}
                  placeholder="Enter your surname"
                  required
                />
              </div>

              <div className="form-group">
                <label>Birthday</label>
                <input
                  type="date"
                  name="birthday"
                  value={formData.birthday}
                  onChange={handleChange}
                  required
                />
              </div>

            </div>
          </section>


          {/* IDENTIFICATION */}
          <section className="form-section">
            <h2>Identification</h2>

            <div className="form-grid">

              <div className="form-group">
                <label>ID Type</label>

                <select
                  name="idType"
                  value={formData.idType}
                  onChange={handleChange}
                  required
                >
                  <option value="">Select ID type</option>
                  <option value="South African ID">
                    South African ID
                  </option>
                  <option value="Passport">
                    Passport
                  </option>
                  <option value="Other">
                    Other
                  </option>
                </select>
              </div>

              <div className="form-group">
                <label>ID Number</label>

                <input
                  type="text"
                  name="idNumber"
                  value={formData.idNumber}
                  onChange={handleChange}
                  placeholder="Enter your ID number"
                  required
                />
              </div>

            </div>
          </section>


          {/* EDUCATION */}
          <section className="form-section">
            <h2>Education</h2>

            <div className="form-grid">

              <div className="form-group">
                <label>School</label>

                <input
                  type="text"
                  name="school"
                  value={formData.school}
                  onChange={handleChange}
                  placeholder="Enter your school"
                  required
                />
              </div>

              <div className="form-group">
                <label>Province</label>

                <select
                  name="province"
                  value={formData.province}
                  onChange={handleChange}
                  required
                >
                  <option value="">Select province</option>

                  {provinces.map((province) => (
                    <option
                      key={province}
                      value={province}
                    >
                      {province}
                    </option>
                  ))}
                </select>
              </div>

            </div>
          </section>


          {/* SUBJECTS */}
          <section className="form-section">
            <div className="section-heading">
              <div>
                <h2>Subjects & Marks</h2>
                <p>
                  Add the subjects you are currently studying and your marks.
                </p>
              </div>

              <button
                type="button"
                className="add-subject-button"
                onClick={addSubject}
              >
                + Add Subject
              </button>
            </div>

            <div className="subjects-container">

              {subjects.map((subject, index) => (
                <div
                  className="subject-row"
                  key={index}
                >

                  <div className="form-group subject-select">
                    <label>Subject {index + 1}</label>

                    <select
                      value={subject.subject}
                      onChange={(e) =>
                        handleSubjectChange(
                          index,
                          "subject",
                          e.target.value
                        )
                      }
                      required
                    >
                      <option value="">
                        Select subject
                      </option>

                      {subjectOptions.map((option) => (
                        <option
                          key={option}
                          value={option}
                        >
                          {option}
                        </option>
                      ))}
                    </select>
                  </div>


                  <div className="form-group mark-input">
                    <label>Mark (%)</label>

                    <input
                      type="number"
                      min="0"
                      max="100"
                      value={subject.mark}
                      onChange={(e) =>
                        handleSubjectChange(
                          index,
                          "mark",
                          e.target.value
                        )
                      }
                      placeholder="0 - 100"
                      required
                    />
                  </div>


                  {subjects.length > 1 && (
                    <button
                      type="button"
                      className="remove-subject-button"
                      onClick={() => removeSubject(index)}
                    >
                      Remove
                    </button>
                  )}

                </div>
              ))}

            </div>
          </section>


          {/* CONTACT INFORMATION */}
          <section className="form-section">
            <h2>Contact Information</h2>

            <div className="form-grid">

              <div className="form-group">
                <label>Phone Number</label>

                <input
                  type="tel"
                  name="phone"
                  value={formData.phone}
                  onChange={handleChange}
                  placeholder="Enter your phone number"
                  required
                />
              </div>

              <div className="form-group">
                <label>Email Address</label>

                <input
                  type="email"
                  name="email"
                  value={formData.email}
                  onChange={handleChange}
                  placeholder="Enter your email"
                  required
                />
              </div>

            </div>
          </section>


          {/* PASSWORD */}
          <section className="form-section">
            <h2>Account Security</h2>

            <div className="form-grid">

              <div className="form-group">
                <label>Password</label>

                <input
                  type="password"
                  name="password"
                  value={formData.password}
                  onChange={handleChange}
                  placeholder="Create a password"
                  required
                />
              </div>

              <div className="form-group">
                <label>Re-enter Password</label>

                <input
                  type="password"
                  name="confirmPassword"
                  value={formData.confirmPassword}
                  onChange={handleChange}
                  placeholder="Re-enter your password"
                  required
                />
              </div>
            </div>
          </section>


          {/* SUBMIT */}
          <div className="form-actions">
            
            <button
              type="button"
              className="back-button"
              onClick={() => setPage("login")}
            >
              Back to Login
            </button>

            <button
              type="submit"
              className="signup-button"
            >
              Create Account
            </button>

          </div>

        </form>

      </div>
    </div>
  );
}

export default Signup;
