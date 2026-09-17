import { useState } from "react";
import Login from "./pages/Login";
import Signup from "./pages/Signup";
import Dashboard from "./pages/Dashboard";
import Profile from "./pages/Profile";
import ProgrammeSearch from "./pages/ProgrammeSearch";
import ProgrammeDetails from "./pages/ProgrammeDetails";

function App() {
  const [page, setPage] = useState("login");
  const [selectedProgramme, setSelectedProgramme] = useState(null);

  const navigate = (nextPage, programme = null) => {
    if (programme) {
      setSelectedProgramme(programme);
    }

    setPage(nextPage);
  };

  if (page === "login") {
    return <Login setPage={setPage} />;
  }

  if (page === "signup") {
    return <Signup setPage={setPage} />;
  }

  if (page === "dashboard") {
    return <Dashboard setPage={setPage} />;
  }

  if (page === "profile") {
    return <Profile setPage={setPage} />;
  }

  if(page === "programmes") {
    return <ProgrammeSearch setPage={navigate} />;
  }

  if (page === "programme-details") {
    return <ProgrammeDetails programme={selectedProgramme} setPage={navigate} />;
  }

  return null;
}

export default App;