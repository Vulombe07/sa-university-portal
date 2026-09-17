import "../App.css";
import { Check, Compass, ShieldCheck } from "lucide-react";

function Login({ setPage }) {
  return (
    <div className="login-page">

      {/* LEFT SIDE */}
      <div className="login-left">
        <div className="logo">
          <div className="logo-icon">U</div>
          <span>UniApply</span>
        </div>

        <div className="hero-content">
          <h1>
            One profile.
            <br />
            Every option.
            <br />
            Your future.
          </h1>

          <p>
            Your university journey starts here. Explore your options,
            check your eligibility and apply with confidence.
          </p>

          <div className="features">
            <div className="feature">
              <div className="feature-icon">
                <Check size={18} strokeWidth={2.5} />
              </div>

              <div>
                <h3>One profile</h3>

                <p>
                  Create your profile once and use it everywhere.
                </p>
              </div>

            </div>


            <div className="feature">

              <div className="feature-icon">
                <Compass size={18} />
              </div>

              <div>
                <h3>Explore programmes</h3>

                <p>
                  Find programmes that match your goals.
                </p>
              </div>

            </div>


            <div className="feature">

              <div className="feature-icon">
                <ShieldCheck size={18} />
              </div>

              <div>
                <h3>Track applications</h3>

                <p>
                  Keep all your applications in one place.
                </p>
              </div>
            </div>

          </div>

        </div>

      </div>


      {/* RIGHT SIDE */}
      <div className="login-right">

        <div className="login-container">

          <div className="login-heading">

            <h2>Welcome back</h2>

            <p>
              Log in to continue your university journey.
            </p>

          </div>


          <div className="form">

            {/* EMAIL */}
            <div className="form-group">

              <label>
                Email Address
              </label>

              <input
                type="email"
                placeholder="Enter your email address"
              />

            </div>


            {/* PASSWORD */}
            <div className="form-group">

              <div className="password-header">

                <label>
                  Password
                </label>

              

              </div>

              <input
                type="password"
                placeholder="Enter your password"
              />

            </div>


            {/* LOGIN */}
            <button
              type="button"
              className="login-button"
              onClick={() => setPage("dashboard")}
            >
              Log In
            </button>

          </div>


          {/* SIGN UP */}
          <div className="signup">

            <span>
              Don't have an account?
            </span>

            <button
              type="button"
              onClick={() => setPage("signup")}
            >
              Sign up
            </button>

          </div>

        </div>

      </div>

    </div>
  );
}

export default Login;