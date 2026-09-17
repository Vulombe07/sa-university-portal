import Sidebar from "./Sidebar";
import TopBar from "./TopBar";

export default function AppLayout({ children, setPage, activePage, showTopBar = false }) {
  return (
    <div className="app-shell">
      <Sidebar setPage={setPage} activePage={activePage} />
      <div className="app-main">
        {showTopBar && <TopBar />}
        <main className="app-content">{children}</main>
      </div>
    </div>
  );
}