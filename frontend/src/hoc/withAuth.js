import React, { useEffect, useState } from 'react';
import { userService } from '@services';
import { useHistory } from 'react-router-dom';

export default function withAuth(InnerComponent) {
  return function WrapperComponent(props) {
    const history = useHistory();
    const [user, setUser] = useState(null);

    const checkLogin = async () => {
      try {
        const { data, status } = await userService.checkLogin();
        if (status === 200) {
          setUser(data.user);
        }
      } catch (err) {
        history.push('/login');
      }
    };

    useEffect(() => {
      checkLogin();
    }, []);

    if (user) return <InnerComponent user={user} {...props} />;
    else return <div>Loading</div>;
  };
}
