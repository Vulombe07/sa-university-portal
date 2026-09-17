import { Bell, Search, ChevronDown } from "lucide-react";

export default function TopBar() {
  return (
    <header className="topbar">
      <div className="topbar-search">
        <Search size={16} />
        <input type="text" placeholder="Search programmes... " />
      </div>

      <div className="topbar-actions">
        </div>
    
    </header>
  );
}
