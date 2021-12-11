import axios from "axios";
import { useState } from "react";

const App = () => {
  const [lineOne] = useState<string>("I like to poop and I cannot lie!");
  const [lineTwo] = useState<string>("You other poopers can't deny!");
  const [lineThree, setLineThree] = useState<string>("Poop come out my bum!");
  const [lineFour, setLineFour] = useState<string>("");

  return (
    <div>
      <h1>{lineOne}</h1>
      <h1>{lineTwo}</h1>
      <h1>{lineThree}</h1>
      <h1>{lineFour}</h1>
      <button onClick={() => setLineThree(() => "SHIT get out of my ASS!!")}>
        SHIT
      </button>
      <button
        onClick={async () => {
          const res = await axios.get(
            "https://jsonplaceholder.typicode.com/todos/1"
          );
          setLineFour(() => res.data.title);
        }}
      >
        GET MORE SHIT
      </button>
    </div>
  );
};

export default App;
