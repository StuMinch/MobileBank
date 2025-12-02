**GOAL:** Generate a complete, multi-file SwiftUI iOS application for a modern Mobile Banking Prototype. The prototype must accurately reflect a professional banking UI/UX and include functional demonstration of inter-tab navigation and camera integration for deposit.

**TECHNOLOGY & CONSTRAINTS:**
1.  **Language/Framework:** SwiftUI (iOS 17+ compatible).
2.  **File Structure:** The code must be cleanly separated into multiple Swift files for each major view/model (e.g., `HomeView.swift`, `TransferView.swift`, `MockData.swift`, `DepositCheckView.swift`).
3.  **Data:** Use static, mocked data (structs and arrays) defined exclusively in `MockData.swift`. No real-time data or persistence.
4.  **Navigation:** The primary navigation MUST be a `TabView` structure, with the main `ContentView` managing the tab selection state via a **Binding** to enable deep linking/inter-tab navigation.

**CORE FUNCTIONALITY & SCREENS (The 5-Tab Structure):**
The app must be structured around a `TabView` with five distinct tags (0 through 4):

| Tab Index | Screen/File | Required Functionality |
| :---: | :--- | :--- |
| **0** | **HomeView.swift** | Displays Total Balance, Account List, and Quick Actions. **CRITICAL:** Quick Action "Deposit" and "Transfer" must navigate away from this tab. |
| **1** | **TransactionsView.swift** | Scrollable, grouped list of recent mock transactions. |
| **2** | **TransferView.swift** | View allowing selection of Source/Destination Accounts and Amount input. This is the destination for the Home tab's Transfer quick action. |
| **3** | **CardsView.swift** | Horizontally scrollable view of mock Credit/Debit Cards. |
| **4** | **MoreView.swift** | Simple `List` view for mock settings/profile links. |

**ENHANCEMENTS & INTERACTIONS (CRITICAL UPDATES):**

1.  **Quick Action Deep Link:** The **"Transfer"** Quick Action button in `HomeView` must programmatically set the main `TabView`'s selection to **Index 2 (`TransferView`)**.
2.  **Mobile Check Deposit:** The **"Deposit"** Quick Action button in `HomeView` must present a **Sheet** containing the `DepositCheckView`.
    * **DepositCheckView.swift** must use a `UIViewControllerRepresentable` (like `ImagePicker`) to access the **iOS camera** (`.camera` source type) for image capture.
    * The view must include fields for **Deposit Account selection** and **Amount entry**.

**AESTHETICS & UX:**
* **Design Theme:** Clean, modern, professional banking theme (Deep Blue `#005691` and gray/white palette).
* **UX Elements:** Use rounded corners (radius 10-16), subtle shadows, and native **SF Symbols** for all icons.
* **Dismissal:** All presented sheets (like `DepositCheckView`) must utilize the modern `@Environment(\.dismiss)` for cancellation/completion.

**MOCK DATA STRUCTURE (REQUIRED STRUCTS):**
Define the following Swift structs in `MockData.swift`: `Account`, `Transaction`, and `Card`.

**FINAL OUTPUT CHECKLIST:**
* All files compile and views render correctly.
* The `TabView` controls the app's root navigation.
* The 'Transfer' quick action correctly switches tabs.
* The 'Deposit' quick action correctly presents the camera-based deposit interface.
