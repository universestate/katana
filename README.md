---

![image](logo.png)

## Cloning the Repository  
Clone the Laterium repository using the following command:  
```bash
git clone https://github.com/universestate/laterium.git
```

---

## Preparing the Environment  
Copy the `.bat` or `.sh` files into the appropriate directory:  
```plaintext
path\to\your\gamemodes
```

---

## Renaming the Files  
Rename the main gamemode file by adding `".lat"` to its name.  
For example:  
```plaintext
main.pwn → main.lat.pwn
```  
*Note: Use lowercase only.*

---

## Running Programs  

### On Windows  
1. Navigate to the batch directory:  
   ```bat
   cd path\to\batch
   ```
2. Run the batch script:  
   ```bat
   batch.bat
   ```

### On Linux/Mac  
1. Navigate to the shell script directory:  
   ```bash
   cd path/to/bash
   ```
2. Make the shell script executable:  
   ```bash
   chmod +x shell.sh
   ```
3. Run the shell script:  
   ```bash
   ./shell.sh
   ```

---

## Running Scripts  

Use the following `cat` commands to access various functions:  

- **Display help information:**  
  ```bash
  cat/help
  ```

- **Compile with Laterium compilers:**  
  ```bash
  cat -c
  ```

- **Compile and launch the server:**  
  ```bash
  cat -ci
  ```

- **Display version information:**  
  ```bash
  cat -v
  ```

---
